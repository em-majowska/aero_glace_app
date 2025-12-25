import 'package:aero_glace_app/features/flavors/flavor_model.dart';
import 'package:aero_glace_app/widgets/my_mesh.dart';
import 'package:aero_glace_app/widgets/tag.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FlavorTile extends StatefulWidget {
  final Flavor flavor;
  const FlavorTile({super.key, required this.flavor});

  @override
  State<FlavorTile> createState() => _FlavorTileState();
}

class _FlavorTileState extends State<FlavorTile> {
  @override
  Widget build(BuildContext context) {
    return GlossyBox(
      child: MyMesh(
        meshPoints: widget.flavor.meshPoints,
        child: Container(
          height: 170,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/images/flavours/bg1.jpg'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
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
                        spacing: 2,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                widget.flavor.title,
                                style: Theme.of(context).textTheme.titleMedium,
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
              Positioned(
                bottom: 10,
                right: 0,

                // Button
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerLowest,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {},
                  child: Icon(
                    LucideIcons.plus,
                    color: Theme.of(context).colorScheme.onSurface,
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
