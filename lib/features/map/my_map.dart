import 'dart:async';
import 'package:aero_glace_app/features/map/location_service.dart';
import 'package:aero_glace_app/features/map/map_elements.dart';
import 'package:aero_glace_app/features/map/permission_service.dart';
import 'package:aero_glace_app/features/map/routing_service.dart';
import 'package:aero_glace_app/features/map/shop_markers.dart';
import 'package:aero_glace_app/features/panier/alert_dialogs.dart';
import 'package:aero_glace_app/model/shop_location_model.dart';
import 'package:aero_glace_app/util/calculate.distance.dart';
import 'package:aero_glace_app/widgets/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart' as p_handler;

/// Widget affichant une carte avec les marqueurs de toutes les boutiques.
///
/// La carte permet :
/// - d’afficher la position actuelle de l’utilisateur,
/// - de placer des marqueurs pour toutes les boutiques fournies,
/// - de générer un itinéraire depuis la localisation de l’utilisateur
///     vers la boutique sélectionnée.
///
/// Arguments :
/// - [shops] : liste des boutiques ([ShopLocation]) à afficher sur la carte.
class MyMap extends StatefulWidget {
  final List<ShopLocation> shops;

  /// Crée la carte [MyMap]
  const MyMap({super.key, required this.shops});

  @override
  State<MyMap> createState() => MyMapState();
}

class MyMapState extends State<MyMap> with WidgetsBindingObserver {
  final MapController _mapController = MapController();

  /// Contrôleur de la carte.
  final PopupController _popupController = PopupController();

  // Services pour gérer la localisation, les permissions et les itinéraires.
  final PermissionService _permissionService = PermissionService();
  final RouteService _routeService = RouteService();
  final LocationService _locationService = LocationService();

  // Localisation actuelle de l’utilisateur, boutique sélectionnée et
  //dernière localisation connue.
  LatLng? _currentLocation, _destination, _lastRouteUpdateLocation;

  // Titre de la destination et informations sur l'itinéraire.
  String? _destinationTitle;
  double? _distance, _duration;

  // Distance minimale (en kilomètres) pour déclencher une mise à jour de
  // l'itinéraire.
  static const double _minDistanceForRouteUpdate = 0.1;

  // Timer pour limiter la fréquence des mises à jour de localisation.
  Timer? _throttleTimer;

  // Liste de points représentant l'itinéraire entre l’utilisateur et la boutique.
  List<LatLng> _route = [];

  // Abonnement au flux de localisation.
  StreamSubscription<LatLng>? _locationSubscription;

  // Statut de la permission de localisation.
  late p_handler.PermissionStatus permission;

  @override
  void initState() {
    _handlePermission();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _locationService.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _throttleTimer?.cancel();

    super.dispose();
  }

  /// Vérifie à nouveau la localisation lorsque l'application reprend.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _handlePermission();
    }
  }

  /// Vérifie et demande la permission de localisation si nécessaire.
  Future<void> _handlePermission() async {
    if (!mounted) return;

    // Vérifie le statut actuel de la permission
    permission = await _permissionService.checkLocationPermission();

    if (permission.isDenied) {
      permission = await _permissionService.requestLocationPermission();

      if (permission.isDenied && mounted) {
        showErrorMessage(
          message: context.tr('localization_permission_refused'),
        );
        return;
      } else if (permission.isGranted) {
        await _initializeLocation();
        return;
      }
    } else if (permission.isPermanentlyDenied && mounted) {
      showErrorMessage(
        message: context.tr('localization_permission_refused'),
      );
      grantLocationDialog(context);
    } else if (permission.isGranted) {
      await _initializeLocation();
      return;
    }
  }

  /// Initialise la localisation et écoute les changements de position.
  ///
  /// - Vérifie si le service de localisation est activé.
  /// - Demande à l'utilisateur d'activer le service si nécessaire.
  /// - Écoute les changements de localisation en temps réel.
  /// - Met à jour [_currentLocation] et déclenche la mise à jour de l'itinéraire si nécessaire.
  Future<void> _initializeLocation() async {
    try {
      // Vérifie si le service de localisation est activé et commence à écouter les changements.
      bool serviceEnabled = await _locationService.isServiceEnabled();

      if (!serviceEnabled) {
        serviceEnabled = await _locationService.requestService();
        if (!serviceEnabled && mounted) {
          showErrorMessage(message: context.tr("localization_off"));
          return;
        }
      }

      // Écoute les changements de localisation
      _locationSubscription = _locationService.onLocationChanged.listen((
        LatLng newLocation,
      ) {
        if (_throttleTimer?.isActive ?? false) return;

        _throttleTimer = Timer(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              _currentLocation = newLocation;
              if (_destination != null) _distance = getDistance(_destination!);
              if (_duration != null) _duration = _routeService.getDuration;
            });

            // Met à jour l'itinéraire si l'utilisateur a bougé suffisamment
            if (_destination != null &&
                (_lastRouteUpdateLocation == null ||
                    calculateDistance(
                          _lastRouteUpdateLocation!.latitude,
                          _lastRouteUpdateLocation!.longitude,
                          newLocation.latitude,
                          newLocation.longitude,
                        ) >
                        _minDistanceForRouteUpdate)) {
              _lastRouteUpdateLocation = newLocation;
              _fetchCoordinatesPoint(_destination!);
            }
          }
        });
      });
    } catch (e) {
      if (mounted) {
        showErrorMessage(message: context.tr('localization_permissions_error'));
      }
    }
  }

  /// Récupère l'itinéraire entre la position actuelle et la boutique sélectionnée.
  ///
  /// Arguments :
  /// - [coords] : Coordonnées de la boutique de destination.
  Future<void> _fetchCoordinatesPoint(LatLng coords) async {
    if (!mounted) return;

    setState(() {
      _destination = coords;
      _destinationTitle = _getCity();
    });

    try {
      if (_currentLocation != null) {
        final route = await _routeService.fetchRoute(
          start: _currentLocation!,
          end: coords,
        );
        if (mounted) {
          setState(() {
            _route = route;
            _distance = getDistance(_destination);
            _duration = _routeService.getDuration;
          });
        }
      }
    } catch (e) {
      if (mounted) showErrorMessage(message: context.tr('fetch_route_error'));
      return;
    }
  }

  /// Récupère le nom de la ville de la boutique sélectionnée.
  ///
  /// Retourne :
  /// - Le nom de la ville de la boutique associée à [_destination].
  String _getCity() {
    final shop = widget.shops.firstWhere(
      (shop) => shop.coordinates == _destination,
    );
    return shop.city;
  }

  /// Calcule la distance entre la position actuelle et une destination.
  ///
  /// Arguments :
  /// - [destination] : Coordonnées de la destination.
  ///
  /// Retourne :
  /// - La distance en kilomètres entre [_currentLocation] et [destination].
  double getDistance(LatLng? destination) {
    if (_currentLocation == null) return 0.0;
    return calculateDistance(
      _currentLocation!.latitude,
      _currentLocation!.longitude,
      destination!.latitude,
      destination.longitude,
    );
  }

  /// Centre la carte sur la position actuelle de l'utilisateur.
  Future<void> _userCurrentLocation() async {
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, 15);
    } else if (permission.isDenied && mounted ||
        permission.isPermanentlyDenied && mounted) {
      grantLocationDialog(context);
    }
  }

  /// Affiche l'itinéraire vers une boutique donnée.
  ///
  /// Arguments :
  /// - [coords] : Coordonnées de la boutique de destinatio
  void showRoute(LatLng coords) {
    _fetchCoordinatesPoint(coords);
  }

  @override
  Widget build(BuildContext context) {
    // Génération des marqueurs pour toutes les boutiques
    final List<Marker> markers = buildShopMarkers(context, widget.shops);

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter:
                  _currentLocation ?? const LatLng(-21.1127, 55.5311),
              initialZoom: 9.5,
              minZoom: 0,
              maxZoom: 100,
            ),
            children: [
              // Tuiles de la carte
              mapView(),

              // Marqueurs des boutiques
              MarkerLayer(markers: markers),

              // Itinéraire si disponible
              if (_currentLocation != null &&
                  _destination != null &&
                  _route.isNotEmpty)
                // Popups des marqueurs
                polylines(_route),

              // Fenêtre d'aperçu de la distance
              popupWindow(
                markers,
                widget.shops,
                _popupController,
                showRoute,
              ),

              if (_destination != null && _route.isNotEmpty)
                distancePreview(
                  context,
                  _destinationTitle,
                  _distance,
                  _duration,
                ),

              // Filigrane OpenStreetMap
              watermark(),

              // Position actuelle de l'utilisateur
              if (_currentLocation != null)
                const CurrentLocationLayer(
                  alignPositionOnUpdate: AlignOnUpdate.always,
                ),
            ],
          ),
        ],
      ),

      // Bouton flottant pour centrer sur la position actuelle de l’utilisateur.
      floatingActionButton: floatingBtn(context, _userCurrentLocation),
    );
  }
}
