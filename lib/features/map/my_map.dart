import 'dart:async';
import 'dart:convert';
import 'package:aero_glace_app/features/panier/alert_dialogs.dart';
import 'package:aero_glace_app/model/shop_location_model.dart';
import 'package:aero_glace_app/util/theme.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:aero_glace_app/widgets/snackbars.dart';
import 'package:aero_glace_app/util/unpack_polyline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:permission_handler/permission_handler.dart' as p_handler;
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:math' show cos, sqrt, asin;

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

  String getCity() {
    final shop = widget.shops.firstWhere(
      (shop) => shop.coordinates == _destination,
    );
    return shop.city;
  }

  Widget createInfoWindow() {
    return Positioned(
      bottom: 5,
      left: 5,
      child: GlossyBox(
        width: 220,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${context.tr('aero_glace')} - $_destinationTitle',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                _distance != null
                    ? '${_distance!.toStringAsFixed(2)} km'
                    : 'Calcul en cours...',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
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

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295;
    final a =
        0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
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

  void showLocation(LatLng coords) {
    _fetchCoordinatesPoint(coords);
    _destinationTitle = getCity();

    // if (_destination != null && mounted) {
    //   setState(() {
    //     _distance = getDistance(_destination!);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    // Génération des marqueurs pour toutes les boutiques
    final List<Marker> markers = List.generate(widget.shops.length, (
      index,
    ) {
      return Marker(
        point: widget.shops[index].coordinates,
        width: 45,
        height: 45,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: context.colorSchema.tertiary,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: CircleAvatar(
            backgroundColor: context.colorSchema.tertiaryContainer,
            child: Icon(
              LucideIcons.iceCreamCone,
              size: 25,
              color: context.colorSchema.onTertiaryContainer,
            ),
          ),
        ),
      );
    });

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
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.aero_glace_app',
              ),
              MarkerLayer(
                markers: markers,
              ),

              // Affiche la route entre l’utilisateur et la boutique si disponible.
              if (_currentLocation != null &&
                  _destination != null &&
                  _route.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _route,
                      strokeWidth: 5,
                      color: Colors.blue,
                    ),
                  ],
                ),
              PopupMarkerLayer(
                options: PopupMarkerLayerOptions(
                  markers: markers,
                  popupController: _popupController,
                  markerCenterAnimation: const MarkerCenterAnimation(),
                  popupDisplayOptions: PopupDisplayOptions(
                    builder: (BuildContext context, Marker marker) {
                      final shop = widget.shops.firstWhere(
                        (shop) => shop.coordinates == marker.point,
                      );
                      return Container(
                        decoration: BoxDecoration(
                          color: context.colorSchema.surface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        constraints: const BoxConstraints(
                          maxWidth: 200,
                          maxHeight: 70,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  // scroll if text is too long
                                  child: Text(
                                    shop.address,
                                    style: context.textTheme.labelLarge,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: double.infinity,
                              child: IconButton(
                                onPressed: () {
                                  showLocation(shop.coordinates);
                                  _popupController.hideAllPopups();
                                },
                                style: IconButton.styleFrom(
                                  padding: const EdgeInsets.all(12),
                                  backgroundColor:
                                      context.colorSchema.tertiaryContainer,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                ),
                                icon: Icon(
                                  LucideIcons.navigation,
                                  color:
                                      context.colorSchema.onTertiaryContainer,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (_route.isNotEmpty || _destination != null) createInfoWindow(),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    '© OpenStreetMap contributors',
                    onTap: () => launchUrl(
                      Uri.parse('https://www.openstreetmap.org/copyright'),
                    ),
                  ),
                ],
              ),
              if (_currentLocation != null)
                const CurrentLocationLayer(
                  alignPositionOnUpdate: AlignOnUpdate.always,
                ),
            ],
          ),
        ],
      ),

      // Bouton flottant pour centrer sur la position actuelle de l’utilisateur.
      floatingActionButton: FloatingActionButton(
        onPressed: _userCurrentLocation,
        backgroundColor: context.colorSchema.tertiaryContainer,
        child: Icon(
          LucideIcons.locateFixed300,
          color: context.colorSchema.onTertiaryContainer,
          size: 30,
        ),
      ),
    );
  }
}
