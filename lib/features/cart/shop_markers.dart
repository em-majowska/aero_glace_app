import 'package:aero_glace_app/models/shop_location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

List<Marker> buildShopMarkers(
  BuildContext context,
  List<ShopLocation> shops,
) {
  return List.generate(shops.length, (index) {
    return Marker(
      point: shops[index].coordinates,
      width: 45,
      height: 45,
      child:
          Container(
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
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
              )
              .animate(delay: Duration(milliseconds: index * 300))
              .scale(curve: Curves.easeInOutBack, duration: 500.ms),
    );
  });
}
