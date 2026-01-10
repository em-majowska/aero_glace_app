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
  /// Contrôleur de la carte.
  final MapController _mapController = MapController();

  /// Contróleur de mark. // TODO
  final PopupController _popupController = PopupController();
  final PermissionService _permissionService = PermissionService();
  final RouteService _routeService = RouteService();
  final LocationService _locationService = LocationService();

  /// Localisation actuelle de l’utilisateur et boutique sélectionnée pour laquelle la route est générée.
  LatLng? _currentLocation, _destination;
  String? _destinationTitle;
  double? _distance;
  LatLng? _lastRouteUpdateLocation;
  static const double _minDistanceForRouteUpdate = 0.1;
  Timer? _throttleTimer;

  /// Liste de points représentant l'itinéraire entre l’utilisateur et la boutique.
  List<LatLng> _route = [];

  StreamSubscription<LatLng>? _locationSubscription;
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

  // Recheck location when the app resumes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _handlePermission();
    }
  }

  /// Vérifie que les permissions de localisation sont activées et accordées.
  Future<void> _handlePermission() async {
    if (!mounted) return;

    permission = await _permissionService.checkLocationPermission();

    // Permission granted ?
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

  /// Initialise la localisation et met à jour [_currentLocation]
  /// lorsque les données sont disponibles.
  ///
  /// - Écoute les changements de localisation en temps réel.
  /// - Met à jour [_currentLocation] dès que les coordonnées sont disponibles.
  /// - Met fin à l’état de chargement lorsque la localisation est connue.
  Future<void> _initializeLocation() async {
    try {
      bool serviceEnabled = await _locationService.isServiceEnabled();

      if (!serviceEnabled) {
        serviceEnabled = await _locationService.requestService();
        if (!serviceEnabled && mounted) {
          showErrorMessage(message: context.tr("localization_off"));
          return;
        }
      }

      // listen
      _locationSubscription = _locationService.onLocationChanged.listen((
        LatLng newLocation,
      ) {
        if (_throttleTimer?.isActive ?? false) return;

        _throttleTimer = Timer(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              _currentLocation = newLocation;
              if (_destination != null) _distance = getDistance(_destination!);
            });

            // Mis à jour l'itinéraire si l'utilisateur a bougé
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

  /// Déclenche la récupération des coordonnées d’une boutique et génère l'itinéraire.
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
          });
        }
      }
    } catch (e) {
      if (mounted) showErrorMessage(message: context.tr('fetch_route_error'));
      return; // TODO check if error showing
    }
  }

  String _getCity() {
    final shop = widget.shops.firstWhere(
      (shop) => shop.coordinates == _destination,
    );
    return shop.city;
  }

  double getDistance(LatLng? destination) {
    if (_currentLocation == null) return 0.0;
    return calculateDistance(
      _currentLocation!.latitude,
      _currentLocation!.longitude,
      destination!.latitude,
      destination.longitude,
    );
  }

  /// Mettre la localisation d'utilisateur au milieu de la carte.
  Future<void> _userCurrentLocation() async {
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, 15);
    } else if (permission.isDenied && mounted ||
        permission.isPermanentlyDenied && mounted) {
      grantLocationDialog(context);
    }
  }

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
              mapView(),
              MarkerLayer(markers: markers),

              // Affiche la route entre l’utilisateur et la boutique si disponible.
              if (_currentLocation != null &&
                  _destination != null &&
                  _route.isNotEmpty)
                polylines(_route),
              popupWindow(
                markers,
                widget.shops,
                _popupController,
                showRoute,
              ),

              if (_destination != null && _route.isNotEmpty)
                distancePreview(context, _destinationTitle, _distance),

              watermark(),

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
