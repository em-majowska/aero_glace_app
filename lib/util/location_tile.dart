import 'package:aero_glace_app/util/glossy_box.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LocationTile extends StatefulWidget {
  final String city;
  final String address;

  const LocationTile({
    super.key,
    required this.city,
    required this.address,
  });

  @override
  State<LocationTile> createState() => _LocationTileState();
}

class _LocationTileState extends State<LocationTile> {
  @override
  Widget build(BuildContext context) {
    return GlossyBox(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            Icon(
              LucideIcons.mapPin300,
              size: 25,
              color: Theme.of(context).colorScheme.primary,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Aero Glace - ${widget.city}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    widget.address,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Container(
              width: 49,
              height: 49,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryFixedDim,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {},
                child: Icon(
                  LucideIcons.navigation,
                  size: 25,
                  color: Theme.of(context).colorScheme.onTertiaryFixed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
