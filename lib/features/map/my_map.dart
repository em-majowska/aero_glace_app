import 'dart:async';
import 'dart:convert';
import 'package:aero_glace_app/features/map/map_elements.dart';
import 'package:aero_glace_app/features/map/shop_markers.dart';
import 'package:aero_glace_app/features/panier/alert_dialogs.dart';
import 'package:aero_glace_app/model/shop_location_model.dart';
import 'package:aero_glace_app/util/calculate.distance.dart';
import 'package:aero_glace_app/widgets/snackbars.dart';
import 'package:aero_glace_app/util/unpack_polyline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as p_handler;
import 'package:http/http.dart' as http;

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

  /// Service de localisation de l'utilisateur.
  final loc.Location _location = loc.Location();

  /// Localisation actuelle de l’utilisateur et boutique sélectionnée pour laquelle la route est générée.
  LatLng? _currentLocation, _destination;
  String? _destinationTitle;
  double? _distance;
  LatLng? _lastRouteUpdateLocation;
  static const double _minDistanceForRouteUpdate = 0.1;
  Timer? _throttleTimer;
  final PopupController _popupController = PopupController();

  /// Liste de points représentant l'itinéraire entre l’utilisateur et la boutique.
  List<LatLng> _route = [];

  /// Abonnement à la mise à jour de la localisation de l’utilisateur.
  StreamSubscription<loc.LocationData>? _locationSubscription;
  late p_handler.PermissionStatus permission;

  @override
  void initState() {
    _handlePermission();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
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
    bool serviceEnabled = await _location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    permission = await p_handler.Permission.locationWhenInUse.status;

    // Permission granted ?
    if (permission.isDenied) {
      permission = await p_handler.Permission.locationWhenInUse.request();

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
      _locationSubscription = _location.onLocationChanged.listen((
        locationData,
      ) {
        if (_throttleTimer?.isActive ?? false) return;

        _throttleTimer = Timer(const Duration(seconds: 1), () async {
          if (locationData.latitude != null &&
              locationData.longitude != null &&
              mounted) {
            final newLocation = LatLng(
              locationData.latitude!,
              locationData.longitude!,
            );

            setState(() {
              _currentLocation = newLocation;
              if (_destination != null) {
                _distance = getDistance(_destination!);
              }
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
              fetchRoute();
            }
          }
        });
      });
    } catch (e) {
      showErrorMessage(message: context.tr('localization_permissions_error'));
    }
  }

  /// Déclenche la récupération des coordonnées d’une boutique et génère l'itinéraire.
  Future<void> _fetchCoordinatesPoint(LatLng coords) async {
    if (mounted) setState(() => _destination = coords);

    await fetchRoute();
  }

  /// Récupère l’itinéraire entre [_currentLocation] et [_destination] via l’OSRM API.
  Future<void> fetchRoute() async {
    if (!mounted) return;
    if (_currentLocation == null || _destination == null) {
      showErrorMessage(message: context.tr('localization_permissions_error'));
      return;
    }

    try {
      final url = Uri.parse(
        'https://router.project-osrm.org/route/v1/driving/'
        '${_currentLocation!.longitude},${_currentLocation!.latitude};'
        '${_destination!.longitude},${_destination!.latitude}?overview=full&geometries=polyline',
      );
      final response = await http.get(url);

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final geometry = data['routes'][0]['geometry'];

        _decodePolyline(geometry);
      } else {
        showErrorMessage(message: context.tr('fetch_route_error'));
        await _location.requestService();
        return;
      }
    } catch (e) {
      showErrorMessage(message: context.tr('fetch_route_error'));
      return;
    }
  }

  /// Décode le polyline obtenu depuis l’API en liste de points pour affichage.
  void _decodePolyline(String encodedPolyline) {
    List<LatLng> decodedPoints = decodePolyline(
      encodedPolyline,
    ).unpackPolyline();

    if (mounted) setState(() => _route = decodedPoints);
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
    _destinationTitle = _getCity();
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
