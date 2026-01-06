import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:aero_glace_app/widgets/my_mesh.dart';
import 'package:aero_glace_app/widgets/tag.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FlavorTile extends StatelessWidget {
  final Flavor flavor;
  final void Function()? onPressed;

  const FlavorTile({
    super.key,
    required this.flavor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget flavorDetails() {
      return Expanded(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    flavor.title,
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    flavor.description,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              Text(
                '${flavor.price.toStringAsFixed(2)} €',
                style: theme.textTheme.titleLarge,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Wrap(
                        runAlignment: WrapAlignment.end,
                        spacing: 5,
                        runSpacing: 5,
                        children: flavor.tags
                            .map((tag) => Tag(tag: tag))
                            .toList(),
                      ),
                    ),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerLowest,
                        overlayColor: theme.colorScheme.primary,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: theme.colorScheme.outlineVariant,
                          ),
                        ),
                      ),
                      onPressed: onPressed,
                      icon: Icon(
                        LucideIcons.plus,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return IntrinsicHeight(
      child: GlossyBox(
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(12),
          child: MyMesh(
            meshPoints: flavor.meshPoints,
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        'assets/images/flavors/${flavor.imagePath}',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),

                    // Details
                    flavorDetails(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
