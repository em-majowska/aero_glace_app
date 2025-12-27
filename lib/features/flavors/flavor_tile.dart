import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:aero_glace_app/widgets/my_mesh.dart';
import 'package:aero_glace_app/widgets/tag.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FlavorTile extends StatefulWidget {
  final Flavor flavor;
  void Function()? onPressed;

  FlavorTile({super.key, required this.flavor, required this.onPressed});

  @override
  State<FlavorTile> createState() => _FlavorTileState();
}

class _FlavorTileState extends State<FlavorTile> {
  @override
  Widget build(BuildContext context) {
    return GlossyBox(
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(12),
        child: MyMesh(
          meshPoints: widget.flavor.meshPoints,
          child: Container(
            height: 170,
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        'assets/images/flavors/${widget.flavor.imagePath}',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),

                    // Right column
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.flavor.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  widget.flavor.description,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            Text(
                              '${widget.flavor.price.toStringAsFixed(2)} €',
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge,
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 200),
                              child: Wrap(
                                runAlignment: WrapAlignment.end,
                                spacing: 5,
                                runSpacing: 5,
                                children: widget.flavor.tags
                                    .map((tag) => Tag(tag: tag))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Button
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: IconButton.filled(
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerLowest,
                      shape: const CircleBorder(),
                    ),
                    onPressed: widget.onPressed,
                    icon: Icon(
                      LucideIcons.plus,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
