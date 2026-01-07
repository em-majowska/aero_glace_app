import 'package:aero_glace_app/model/cart_controller.dart';
import 'package:aero_glace_app/model/fortune_wheel_controller.dart';
import 'package:aero_glace_app/pages/about_page.dart';
import 'package:aero_glace_app/pages/bonus_page.dart';
import 'package:aero_glace_app/pages/map_page.dart';
import 'package:aero_glace_app/pages/cart_page.dart';
import 'package:aero_glace_app/pages/flavors_page.dart';
import 'package:easy_localization/easy_localization.dart';
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
    const AboutPage(),
    const FlavorsPage(),
    const CartPage(),
    const BonusPage(),
    const MapPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => FortuneWheelController()),
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
              // check if cart is empty and add badge if needed
              icon: Builder(
                builder: (context) {
                  final qty = Provider.of<CartController>(
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
