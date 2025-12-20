import 'package:aero_glace_app/pages/carte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
// import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
// import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class MyMap extends StatelessWidget {
  final List<ShopLocation> shopLocations;
  const MyMap({super.key, required this.shopLocations});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = MapController();

    // Marker template
    final List<Marker> markers = List.generate(shopLocations.length, (index) {
      return Marker(
        point: shopLocations[index].coordinates,
        width: 49,
        height: 49,
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

    // final Location _location = Location();
    // bool _serviceEnabled = false;
    // PermissionStatus? _permissionGranted;

    // @override
    // void initState() {
    //   super.initState();
    //   _checkLocationPermissions();
    // }

    // Future<void> _checkLocationPermissions() async {
    //   _serviceEnabled = await _location.serviceEnabled();
    //   if (!_serviceEnabled) {
    //     _serviceEnabled = await _location.requestService();
    //     if (!_serviceEnabled) return;
    //   }

    //   _permissionGranted = await _location.hasPermission();
    //   if (_permissionGranted == PermissionStatus.denied) {
    //     _permissionGranted = await _location.requestPermission();
    //     if (_permissionGranted != PermissionStatus.granted) return;
    //   }
    // }

    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: const MapOptions(
            initialCenter: LatLng(-21.1127, 55.5311),
            initialZoom: 9.5,
            minZoom: 0,
            maxZoom: 100,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.em-majowska.aero_glace_app',
            ),
            // CurrentLocationLayer(
            //   style: LocationMarkerStyle(
            //     marker: DefaultLocationMarker(
            //       color: Theme.of(context).colorScheme.tertiary,
            //       child: const Icon(LucideIcons.mapPin),
            //     ),
            //     markerSize: const Size(35, 35),
            //     markerDirection: MarkerDirection.heading,
            //   ),
            // ),
            MarkerLayer(
              markers: markers,
            ),
            PopupMarkerLayer(
              options: PopupMarkerLayerOptions(
                markers: markers,
                popupDisplayOptions: PopupDisplayOptions(
                  builder: (BuildContext context, Marker marker) {
                    final shop = shopLocations.firstWhere(
                      (shop) => shop.coordinates == marker.point,
                    );
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
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
          ],
        ),
      ],
    );
  }
}
