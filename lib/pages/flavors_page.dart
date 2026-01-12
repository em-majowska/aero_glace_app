// import 'package:aero_glace_app/data/default_flavors.dart';
import 'package:aero_glace_app/data/flavors_list.dart';
import 'package:aero_glace_app/features/flavors/flavor_tile.dart';
import 'package:aero_glace_app/utils/animations.dart';
import 'package:aero_glace_app/utils/context_extensions.dart';
import 'package:aero_glace_app/widgets/app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

final flavors = getFlavors();

/// Page affichant la liste des parfums disponibles.
///
/// Retourne un [Scaffold] contenant une [AppBar] incluant
/// un sélecteur de langue et une liste de parfums
/// sous forme de tuiles [FlavorTile].
class FlavorsPage extends StatelessWidget {
  /// Crée la page des parfums.
  const FlavorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar().appBar(context, context.tr('nos_parfums')),
      backgroundColor: context.colorSchema.secondaryContainer,
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: flavors.length,
          itemBuilder: (context, index) {
            // Récupère la liste des parfums en fonction de la localisation
            final flavor = flavors[index];
            return FlavorTile(flavor: flavor).animate(
              delay: Duration(milliseconds: index * 300),
              effects: slideIn,
            );
          },
        ),
      ),
    );
  }
}
