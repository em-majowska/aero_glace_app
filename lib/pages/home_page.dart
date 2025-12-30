import 'package:aero_glace_app/model/cart_model.dart';
import 'package:aero_glace_app/model/fortune_wheel_model.dart';
import 'package:aero_glace_app/pages/accueil_page.dart';
import 'package:aero_glace_app/pages/bonus_page.dart';
import 'package:aero_glace_app/pages/carte_page.dart';
import 'package:aero_glace_app/pages/panier_page.dart';
import 'package:aero_glace_app/pages/parfums_page.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // currently selected page
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // pages in the app
  final List _pages = [
    const AccueilPage(),
    const ParfumsPage(),
    const PanierPage(),
    const BonusPage(),
    const CartePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => FortuneWheelModel()),
      ],
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
          selectedItemColor: Colors.deepPurple.shade400,
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
            BottomNavigationBarItem(
              label: 'Panier',

              // check if cart is empty and add badge if needed
              icon: Builder(
                builder: (context) {
                  final qty = Provider.of<Cart>(
                    context,
                    listen: true,
                  ).totalQuantity;
                  if (qty < 1) {
                    return const Icon(LucideIcons.shoppingBag);
                  } else {
                    return Badge(
                      label: Text(qty.toString()),
                      child: const Icon(LucideIcons.shoppingBag),
                    );
                  }
                },
              ),
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
      ),
    );
  }
}
