// map floating action button

import 'package:aero_glace_app/model/shop_location_model.dart';
import 'package:aero_glace_app/util/theme.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

// map

Widget mapView() {
  return TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'com.aero_glace_app',
  );
}

// route layer
Widget polylines(List<LatLng> route) {
  return PolylineLayer(
    polylines: [
      Polyline(
        points: route,
        strokeWidth: 5,
        color: Colors.blue,
      ),
    ],
  );
}

// popup marker layer
Widget popupWindow(
  List<Marker> markers,
  List<ShopLocation> shops,
  PopupController controller,
  void Function(LatLng) showRoute,
) {
  return PopupMarkerLayer(
    options: PopupMarkerLayerOptions(
      markers: markers,
      popupController: controller,
      markerCenterAnimation: const MarkerCenterAnimation(),
      popupDisplayOptions: PopupDisplayOptions(
        builder: (BuildContext context, Marker marker) {
          final shop = shops.firstWhere(
            (shop) => shop.coordinates == marker.point,
          );
          return popupWindowChild(
            context,
            shop,
            () {
              showRoute(shop.coordinates);
              controller.hideAllPopups();
            },
          );
        },
      ),
    ),
  );
}

// popup marker window
Widget popupWindowChild(
  BuildContext context,
  ShopLocation shop,
  VoidCallback onPressed,
) {
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
            child: Text(
              shop.address,
              style: context.textTheme.labelLarge,
            ),
          ),
        ),

        SizedBox(
          height: double.infinity,
          child: IconButton(
            onPressed: onPressed,
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(12),
              backgroundColor: context.colorSchema.tertiaryContainer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
            ),
            icon: Icon(
              LucideIcons.navigation,
              color: context.colorSchema.onTertiaryContainer,
            ),
          ),
        ),
      ],
    ),
  );
}

// distance preview window

Widget distancePreview(BuildContext context, title, double? distance) {
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
              '${context.tr('aero_glace')} - $title',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              distance != null
                  ? '${distance.toStringAsFixed(2)} ${context.tr('km')}'
                  : context.tr('distance_loading'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    ),
  );
}

// watermark openstreetmaps
Widget watermark() {
  return RichAttributionWidget(
    attributions: [
      TextSourceAttribution(
        '© OpenStreetMap contributors',
        onTap: () => launchUrl(
          Uri.parse('https://www.openstreetmap.org/copyright'),
        ),
      ),
    ],
  );
}

// floating btn

Widget floatingBtn(BuildContext context, curLocation) {
  return FloatingActionButton(
    onPressed: curLocation,
    backgroundColor: context.colorSchema.tertiaryContainer,
    child: Icon(
      LucideIcons.locateFixed300,
      color: context.colorSchema.onTertiaryContainer,
      size: 30,
    ),
  );
}
