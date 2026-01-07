import 'package:aero_glace_app/features/flavors/flavor_details.dart';
import 'package:aero_glace_app/model/cart_controller.dart';
import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:aero_glace_app/widgets/snack_bar.dart';
import 'package:aero_glace_app/widgets/my_mesh.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:provider/provider.dart';

/// Widget affichant une tuile de parfum.
///
/// Affiche l’image du parfum, ses détails (titre, description, prix, tags)
/// et un bouton pour l’ajouter au panier avec une animation de dégradé maillé.
/// [flavor] Le modèle de données du parfum à afficher.
class FlavorTile extends StatefulWidget {
  /// Modèle de parfum associé à cette tuile.
  final Flavor flavor;

  const FlavorTile({super.key, required this.flavor});

  @override
  State<FlavorTile> createState() => _FlavorTileState();
}

class _FlavorTileState extends State<FlavorTile> {
  // Contrôleur de l’animation du dégradé maillé
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

  /// Ajoute le parfum au panier et déclenche l’animation du dégradé maillé.
  void addFlavorToCart(Flavor flavor) {
    Provider.of<CartController>(context, listen: false).addItem(flavor);
    _showMessage(context, flavor);
    _controller.start();
    Future.delayed(const Duration(seconds: 2), () {
      _controller.stop();
    });
  }

  /// Affiche un message de confirmation lorsque le parfum est ajouté au panier.
  void _showMessage(BuildContext context, Flavor flavor) {
    ScaffoldMessenger.of(
      context,
    ).hideCurrentSnackBar(); // TODO add smooth animation
    ScaffoldMessenger.of(context).showSnackBar(
      /* snackBarAnimationStyle: AnimationStyle */
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
    return IntrinsicHeight(
      child: GlossyBox(
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(12),
          child: Stack(
            children: [
              // Dégradé maillé animé
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
                  FlavorDetails(
                    flavor: widget.flavor,
                    onAddToCart: addFlavorToCart,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
