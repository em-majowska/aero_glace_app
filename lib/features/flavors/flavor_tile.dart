import 'package:aero_glace_app/features/flavors/flavor_details.dart';
import 'package:aero_glace_app/providers/cart_controller.dart';
import 'package:aero_glace_app/models/flavor_model.dart';
import 'package:aero_glace_app/utils/theme.dart';
import 'package:aero_glace_app/widgets/my_mesh.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:aero_glace_app/widgets/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:provider/provider.dart';

/// Widget affichant une tuile de parfum.
///
/// Affiche l’image du parfum, ses détails (titre, description, prix, tags)
/// et un bouton pour l’ajouter au panier [onAddToCart] avec une animation de dégradé maillé.
///
/// Argument :
/// - [flavor] : le modèle de données du parfum à utiliser.
class FlavorTile extends StatefulWidget {
  /// Modèle de parfum associé à cette tuile.
  final Flavor flavor;

  /// Crée le widget [FlavorTile] pour afficher le parfum associé dans
  /// la liste de parfums disponibles.
  const FlavorTile({super.key, required this.flavor});

  @override
  State<FlavorTile> createState() => _FlavorTileState();
}

class _FlavorTileState extends State<FlavorTile>
    with AutomaticKeepAliveClientMixin {
  // Contrôleur de l’animation du dégradé maillé
  late final AnimatedMeshGradientController _controller;
  bool _animated = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = AnimatedMeshGradientController();
  }

  @override
  void dispose() {
    /// Libère le contrôleur de l'animation lors de la destruction du widget
    /// poour éviter les fuites de données.
    _controller.dispose();
    super.dispose();
  }

  /// Ajoute le parfum au panier et déclenche l’animation du dégradé maillé.
  void addFlavorToCart(Flavor flavor) {
    // Permet d'accéder à méthode pour ajouter les items au panier.
    final cart = context.read<CartController>();
    cart.addItem(flavor);

    /// Affiche un message de confirmation lorsque le parfum est ajouté au panier.
    showSnack(
      message: context.tr(
        'added_to_cart',
        namedArgs: {'flavorTitle': flavor.title.tr()},
      ),
      icon: Icon(
        LucideIcons.circleCheck300,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
    _controller.start();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _controller.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Widget tileContent() {
      return GlossyBox(
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(12),
          child: Stack(
            children: [
              // Dégradé maillé animé
              Positioned.fill(
                child: MyMesh(
                  meshColors: widget.flavor.meshColors,
                  controller: _controller,
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 190),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image du parfum
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        'assets/images/flavors/${widget.flavor.imagePath}',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),

                    // Details du parfum
                    Expanded(
                      flex: 3,
                      child: FlavorDetails(flavor: widget.flavor),
                    ),
                  ],
                ),
              ),

              Positioned(
                right: 5,
                bottom: 5,
                child: IconButton.filled(
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
              ),
            ],
          ),
        ),
      );
    }

    if (_animated) {
      _animated = true;
      return tileContent();
    }

    return tileContent();
  }
}
