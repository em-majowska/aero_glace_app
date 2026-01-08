import 'dart:async';
import 'dart:convert';
import 'package:aero_glace_app/model/shop_location_model.dart';
import 'package:aero_glace_app/util/theme.dart';
import 'package:aero_glace_app/widgets/error_message.dart';
import 'package:aero_glace_app/util/unpack_polyline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
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

class MyMapState extends State<MyMap> {
  /// Contrôleur de la carte.
  final MapController _mapController = MapController();

  /// Service de localisation de l'utilisateur.
  final Location _location = Location();
  bool isLoading = true;

  /// Localisation actuelle de l’utilisateur.
  LatLng? _currentLocation;

  /// Boutique sélectionnée pour laquelle la route est générée.
  LatLng? _destination;

  /// Liste de points représentant la route entre l’utilisateur et la boutique.
  List<LatLng> _route = [];

  /// Abonnement à la mise à jour de la localisation de l’utilisateur.
  StreamSubscription<LocationData>? _locationSubscription;

  @override
  void initState() {
    _initializeLocation();
    super.initState();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  /// Initialise la localisation et met à jour [_currentLocation]
  /// lorsque les données sont disponibles.
  ///
  /// - Vérifie que les permissions sont accordées via [_checktheRequestPermissions].
  /// - Écoute les changements de localisation en temps réel.
  /// - Met à jour [_currentLocation] dès que les coordonnées sont disponibles.
  /// - Met fin à l’état de chargement lorsque la localisation est connue.
  Future<void> _initializeLocation() async {
    if (!await _checktheRequestPermissions()) return;

    // update current location
    _locationSubscription = _location.onLocationChanged.listen((
      LocationData locationData,
    ) {
      if (locationData.latitude != null && locationData.longitude != null) {
        if (mounted) {
          setState(() {
            _currentLocation = LatLng(
              locationData.latitude!,
              locationData.longitude!,
            );
            isLoading = false; // stop loading when location is known
          });
        }
      }
    });
  }

  /// Déclenche la récupération des coordonnées d’une boutique et génère la route.
  Future<void> _fetchCoordinatesPoint(LatLng coords) async {
    if (mounted) {
      setState(() {
        _destination = coords;
      });
    }
    await fetchRoute();
  }

  /// Récupère l’itinéraire entre [_currentLocation] et [_destination] via l’OSRM API.
  Future<void> fetchRoute() async {
    if (_currentLocation == null || _destination == null) return;

    final url = Uri.parse(
      'https://router.project-osrm.org/route/v1/driving/'
      '${_currentLocation!.longitude},${_currentLocation!.latitude};'
      '${_destination!.longitude},${_destination!.latitude}?overview=full&geometries=polyline',
    );
    try {
      final response = await http.get(url);

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final geometry = data['routes'][0]['geometry'];

        _decodePolyline(geometry);
      } else {
        if (mounted) {
          errorMessage(context, context.tr('fetch_route_error'));
          await _location.requestService();
        }
        return;
      }
    } catch (e) {
      errorMessage(context, context.tr('fetch_route_error'));

      return;
    }
  }

  /// Décode le polyline obtenu depuis l’API en liste de points pour affichage.
  void _decodePolyline(String encodedPolyline) {
    List<LatLng> decodedPoints = decodePolyline(
      encodedPolyline,
    ).unpackPolyline();

    if (mounted) {
      setState(() {
        _route = decodedPoints;
      });
    }
  }

  /// Vérifie que les permissions de localisation sont activées et accordées.
  Future<bool> _checktheRequestPermissions() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return false;
    }
    // TODO handle try catch in case if there is no new location permission dialog prompt
    PermissionStatus permissionGranted = await _location.hasPermission();
    // TODO handle PermissionStatus.deniedForever

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  /// Déclenche la génération de la route vers la boutique sélectionnée.
  Future<void> _userCurrentLocation() async {
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, 15);
    } else {
      errorMessage(context, context.tr('localization_permissions_error'));
      _initializeLocation();
    }
  }

  void showLocation(LatLng coords) {
    _fetchCoordinatesPoint(coords);
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
                  popupDisplayOptions: PopupDisplayOptions(
                    builder: (BuildContext context, Marker marker) {
                      final shop = widget.shops.firstWhere(
                        (shop) => shop.coordinates == marker.point,
                      );
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: context.colorSchema.surface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          shop.address,
                          style: context.textTheme.labelLarge,
                        ),
                      );
                    },
                  ),
                ),
              ),
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
              if (_currentLocation != null) const CurrentLocationLayer(),
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
