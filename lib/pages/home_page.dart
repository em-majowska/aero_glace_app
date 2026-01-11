import 'package:aero_glace_app/providers/cart_controller.dart';
import 'package:aero_glace_app/providers/fortune_wheel_controller.dart';
import 'package:aero_glace_app/pages/about_page.dart';
import 'package:aero_glace_app/pages/bonus_page.dart';
import 'package:aero_glace_app/pages/map_page.dart';
import 'package:aero_glace_app/pages/cart_page.dart';
import 'package:aero_glace_app/pages/flavors_page.dart';
import 'package:aero_glace_app/utils/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

///
/// Page principale de l'application.
///
/// Affiche la navigation par barre inférieure
/// et affiche la page correspondante à l’onglet sélectionné.
class HomePage extends StatefulWidget {
  /// Crée la page principale.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Index de l’onglet actuellement sélectionné
  int _selectedIndex = 0;

  /// Contrôleur pour piloter la navigation entre
  /// les pages de la [PageView].
  final PageController _pageController = PageController();

  // Change la page affichée lors de la sélection
  // d’un élément de la barre de navigation
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Animation fluide vers la page sélectionnée
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Liste des pages associées aux onglets
  final List<Widget> _pages = [
    const AboutPage(),
    const FlavorsPage(),
    const CartPage(),
    const BonusPage(),
    const MapPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Fournit les contrôleurs nécessaires à l’ensemble
    // des pages accessibles depuis la navigation principale
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => FortuneWheelController()),
      ],
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: context.colorSchema.surfaceContainer,
          unselectedItemColor: context.colorSchema.onSurfaceVariant,
          selectedItemColor: Colors.deepPurple.shade400,
          elevation: 3,
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          items: [
            BottomNavigationBarItem(
              label: context.tr('accueil'),
              icon: const Icon(LucideIcons.house),
            ),
            BottomNavigationBarItem(
              label: context.tr('parfums'),
              icon: const Icon(LucideIcons.iceCreamCone),
            ),
            BottomNavigationBarItem(
              label: context.tr('panier'),
              icon: Builder(
                builder: (context) {
                  // Quantité totale d’articles présents dans le panier
                  final qty = Provider.of<CartController>(
                    context,
                    listen: true,
                  ).totalQuantity;

                  // Affiche un badge sur l’icône du panier
                  // uniquement si la quantité est supérieure à 0
                  return (qty < 1)
                      ? const Icon(LucideIcons.shoppingBag)
                      : Badge(
                          label: Text(qty.toString()),
                          child: const Icon(LucideIcons.shoppingBag),
                        );
                },
              ),
            ),
            BottomNavigationBarItem(
              label: context.tr('bonus'),
              icon: const Icon(LucideIcons.gift),
            ),
            BottomNavigationBarItem(
              label: context.tr('carte'),
              icon: const Icon(LucideIcons.mapPin),
            ),
          ],
        ),
      ),
    );
  }
}
