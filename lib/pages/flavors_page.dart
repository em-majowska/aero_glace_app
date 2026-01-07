// import 'package:aero_glace_app/data/default_flavors.dart';
import 'package:aero_glace_app/data/flavors_list.dart';
import 'package:aero_glace_app/features/flavors/flavor_tile.dart';
import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:aero_glace_app/util/theme.dart';
import 'package:aero_glace_app/widgets/language_menu_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Page affichant la liste des parfums disponibles.
///
/// Retourne un [Scaffold] contenant une [AppBar] incluant
/// un sélecteur de langue et une liste de parfums
/// sous forme de tuiles [FlavorTile].
class FlavorsPage extends StatefulWidget {
  /// Crée la page des parfums.
  const FlavorsPage({super.key});

  @override
  State<FlavorsPage> createState() => _FlavorsPageState();
}

class _FlavorsPageState extends State<FlavorsPage> {
  List<Flavor>? _flavors;

  @override
  Widget build(BuildContext context) {
    // Récupère la liste des parfums en fonction de la localisation
    _flavors = getFlavors(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('nos_parfums')),
        actions: [const LanguageMenuButton()],
        backgroundColor: context.colorSchema.surface,
        scrolledUnderElevation: 0.0,
        shadowColor: Colors.transparent,
      ),
      backgroundColor: context.colorSchema.secondaryContainer,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemCount: _flavors!.length,
        itemBuilder: (context, index) {
          final flavor = _flavors![index];
          return FlavorTile(
            flavor: flavor,
          );
        },
      ),
    );
  }
}
