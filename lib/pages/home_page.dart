import 'package:aero_glace_app/model/cart_model.dart';
import 'package:aero_glace_app/model/fortune_wheel_model.dart';
import 'package:aero_glace_app/pages/accueil_page.dart';
import 'package:aero_glace_app/pages/bonus_page.dart';
import 'package:aero_glace_app/pages/carte_page.dart';
import 'package:aero_glace_app/pages/panier_page.dart';
import 'package:aero_glace_app/pages/parfums_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
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

  late Locale currentLang;

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
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        currentLang = FlutterI18n.currentLocale(context) ?? const Locale('fr');
      });
    });
  }

  void changeLanguage() {
    setState(() {
      currentLang = currentLang.languageCode == 'fr'
          ? const Locale('ja')
          : const Locale('fr');
    });
  }

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
            BottomNavigationBarItem(
              label: FlutterI18n.translate(context, "accueil"),
              icon: const Icon(LucideIcons.house),
            ),
            BottomNavigationBarItem(
              label: FlutterI18n.translate(context, "parfums"),
              icon: const Icon(LucideIcons.iceCreamCone),
            ),
            BottomNavigationBarItem(
              label: FlutterI18n.translate(context, "panier"),

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
            BottomNavigationBarItem(
              label: FlutterI18n.translate(context, "bonus"),
              icon: const Icon(LucideIcons.gift),
            ),
            BottomNavigationBarItem(
              label: FlutterI18n.translate(context, "carte"),
              icon: const Icon(LucideIcons.mapPin),
            ),
          ],
        ),
      ),
    );
  }
}
