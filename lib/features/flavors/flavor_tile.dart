import 'package:aero_glace_app/model/cart_controller.dart';
import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:aero_glace_app/util/theme.dart';
import 'package:aero_glace_app/widgets/snack_bar.dart';
import 'package:aero_glace_app/widgets/my_mesh.dart';
import 'package:aero_glace_app/features/flavors/tag.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:provider/provider.dart';

class FlavorTile extends StatefulWidget {
  final Flavor flavor;

  const FlavorTile({
    super.key,
    required this.flavor,
  });

  @override
  State<FlavorTile> createState() => _FlavorTileState();
}

class _FlavorTileState extends State<FlavorTile> {
  late final AnimatedMeshGradientController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimatedMeshGradientController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void addFlavorToCart(Flavor flavor) {
    Provider.of<CartController>(context, listen: false).addItem(flavor);
    _showMessage(context, flavor);
    _controller.start();
    Future.delayed(const Duration(seconds: 2), () {
      _controller.stop();
    });
  }

  // show message
  void _showMessage(BuildContext context, Flavor flavor) {
    ScaffoldMessenger.of(
      context,
    ).hideCurrentSnackBar(); // TODO add smooth animation
    ScaffoldMessenger.of(context).showSnackBar(
      // snackBarAnimationStyle: AnimationStyle TODO add smooth animation
      MySnackBar(
        context: context,
        icon: Icon(
          LucideIcons.circleCheck300,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        message: context.tr(
          'added_to_cart',
          namedArgs: {
            'flavorTitle': flavor.title,
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    widget.flavor.title,
                    style: context.textTheme.titleMedium,
                  ),
                  Text(
                    widget.flavor.description,
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
              Text(
                '${widget.flavor.price.toStringAsFixed(2)} €',
                style: context.textTheme.titleLarge,
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
                        children: widget.flavor.tags
                            .map((tag) => Tag(tag: tag))
                            .toList(),
                      ),
                    ),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerLowest,
                        overlayColor: context.colorSchema.primary,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: context.colorSchema.outlineVariant,
                          ),
                        ),
                      ),
                      onPressed: () => addFlavorToCart(widget.flavor),
                      icon: Icon(
                        LucideIcons.plus,
                        color: context.colorSchema.onSurface,
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
          child: Stack(
            children: [
              MyMesh(
                meshColors: widget.flavor.meshColors,
                controller: _controller,
              ),
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

                  // Details
                  flavorDetails(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
