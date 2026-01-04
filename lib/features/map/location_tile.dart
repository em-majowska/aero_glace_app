import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:latlong2/latlong.dart';

class LocationTile extends StatefulWidget {
  final String city;
  final String address;
  final LatLng coordinates;
  final void Function(LatLng)? onPressed;

  const LocationTile({
    super.key,
    required this.city,
    required this.address,
    required this.coordinates,
    required this.onPressed,
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
        child: IntrinsicHeight(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${FlutterI18n.translate(context, "aero-glace")} - ${widget.city}',
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
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () => widget.onPressed!(widget.coordinates),
                  child: Icon(
                    LucideIcons.navigation,
                    size: 25,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO fix splash button
