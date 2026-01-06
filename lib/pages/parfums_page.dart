// import 'package:aero_glace_app/data/default_flavors.dart';
import 'package:aero_glace_app/data/default_flavors.dart';
import 'package:aero_glace_app/features/flavors/flavor_tile.dart';
import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:aero_glace_app/widgets/language_menu_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ParfumsPage extends StatefulWidget {
  const ParfumsPage({super.key});

  @override
  State<ParfumsPage> createState() => _ParfumsPageState();
}

class _ParfumsPageState extends State<ParfumsPage> {
  List<Flavor>? _flavors;

  @override
  Widget build(BuildContext context) {
    _flavors = getDefaultFlavors(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('nos_parfums')),
        actions: [const LanguageMenuButton()],
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0.0,
        shadowColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
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
