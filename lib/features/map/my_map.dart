import 'dart:convert';
import 'package:aero_glace_app/model/shop_location_model.dart';
import 'package:aero_glace_app/model/snack_bar.dart';

import 'package:aero_glace_app/util/unpack_polyline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class MyMap extends StatefulWidget {
  final List<ShopLocation> shops;
  const MyMap({super.key, required this.shops});

  @override
  State<MyMap> createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  final MapController _mapController = MapController();
  final Location _location = Location();
  bool isLoading = true;

  LatLng? _currentLocation;
  LatLng? _destination;
  List<LatLng> _route = [];

  @override
  void initState() {
    _initializeLocation();
    super.initState();
  }

  Future<void> _initializeLocation() async {
    if (!await _checktheRequestPermissions()) return;

    // update current location
    _location.onLocationChanged.listen((LocationData locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        setState(() {
          _currentLocation = LatLng(
            locationData.latitude!,
            locationData.longitude!,
          );
          isLoading = false; // stop loading when location is known
        });
      }
    });
  }

  // fetch coords for a given location
  Future<void> _fetchCoordinatesPoint(LatLng coords) async {
    setState(() {
      _destination = coords;
    });
    await fetchRoute();
  }

  // fetch the route between current location and the destination (OSRM API)
  Future<void> fetchRoute() async {
    if (_currentLocation == null || _destination == null) return;
    final url = Uri.parse(
      'https://router.project-osrm.org/route/v1/driving/'
      '${_currentLocation!.longitude},${_currentLocation!.latitude};'
      '${_destination!.longitude},${_destination!.latitude}?overview=full&geometries=polyline',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final geometry = data['routes'][0]['geometry'];

      _decodePolyline(geometry);
    } else {
      errorMessage(
        'Échec de la récupération de l\'itinéraire. Veuillez réessayer plus tard.',
      );
    }
  }

  // decode polyline string into a graphical route
  void _decodePolyline(String encodedPolyline) {
    List<LatLng> decodedPoints = decodePolyline(
      encodedPolyline,
    ).unpackPolyline();

    setState(() {
      _route = decodedPoints
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    });
  }

  // check if location service is enabled and granted
  Future<bool> _checktheRequestPermissions() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return false;
    }

    PermissionStatus permissionGranted = await _location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  Future<void> _userCurrentLocation() async {
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, 15);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        MySnackBar(
          context: context,
          icon: const Icon(LucideIcons.badgeAlert),
          message:
              'La localisation n\'est pas accessible. Veuillez vérifier les permissions.',
        ),
      );
    }
  }

  void errorMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      MySnackBar(
        context: context,
        icon: const Icon(LucideIcons.triangleAlert),
        message: message,
      ),
    );
  }

  void showLocation(LatLng coords) {
    _fetchCoordinatesPoint(coords);
  }

  @override
  Widget build(BuildContext context) {
    // Marker template
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
              color: Theme.of(context).colorScheme.tertiary,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: CircleAvatar(
            backgroundColor: Theme.of(
              context,
            ).colorScheme.tertiaryContainer,
            child: Icon(
              LucideIcons.iceCreamCone,
              size: 25,
              color: Theme.of(
                context,
              ).colorScheme.onTertiaryContainer,
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
                userAgentPackageName: 'com.em-majowska.aero_glace_app',
              ),
              MarkerLayer(
                markers: markers,
              ),
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
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          shop.address,
                          style: Theme.of(context).textTheme.labelLarge,
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
              const CurrentLocationLayer(),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _userCurrentLocation,
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        child: Icon(
          LucideIcons.locateFixed300,
          color: Theme.of(context).colorScheme.onTertiaryContainer,
          size: 30,
        ),
      ),
    );
  }
}
