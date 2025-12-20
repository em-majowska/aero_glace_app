import 'package:aero_glace_app/pages/accueil.dart';
import 'package:aero_glace_app/pages/bonus.dart';
import 'package:aero_glace_app/pages/carte.dart';
import 'package:aero_glace_app/pages/panier.dart';
import 'package:aero_glace_app/pages/parfums.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // currently selected page
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // pages in the app
  final List _pages = [
    const Accueil(),
    const Parfums(),
    const Panier(),
    const Bonus(),
    const Carte(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        elevation: 3,
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        items: [
          const BottomNavigationBarItem(
            label: 'Accueil',
            icon: Icon(LucideIcons.house),
          ),
          const BottomNavigationBarItem(
            label: 'Parfums',
            icon: Icon(LucideIcons.iceCreamCone),
          ),
          const BottomNavigationBarItem(
            label: 'Panier',
            icon: Icon(LucideIcons.shoppingBag),
          ),
          const BottomNavigationBarItem(
            label: 'Bonus',
            icon: Icon(LucideIcons.gift),
          ),
          const BottomNavigationBarItem(
            label: 'Carte',
            icon: Icon(LucideIcons.mapPin),
          ),
        ],
      ),
    );
  }
}
