import 'package:aero_glace_app/features/panier/cart_provider.dart';
import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:flutter/material.dart';
import 'package:aero_glace_app/pages/home_page.dart';
import 'package:aero_glace_app/pages/accueil_page.dart';
import 'package:aero_glace_app/pages/parfums_page.dart';
import 'package:aero_glace_app/pages/panier_page.dart';
import 'package:aero_glace_app/pages/bonus_page.dart';
import 'package:aero_glace_app/pages/carte_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
// import 'util.dart';
// import 'theme.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  // register adapter
  // Hive.registerAdapter(FlavorAdapter());
  // open the box
  // await Hive.openBox<Flavor>('cartBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurpleAccent,
            brightness: Brightness.light,
          ),
        ),
        // textTheme: TextTheme(
        //   headlineMedium: GoogleFonts.inter(
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        // ),
        routes: {
          '/accueil': (context) => const AccueilPage(),
          '/parfums': (context) => const ParfumsPage(),
          '/panier': (context) => const PanierPage(),
          '/bonus': (context) => const BonusPage(),
          '/carte': (context) => const CartePage(),
        },
        home: const HomePage(),
      ),
    );
  }
}

// my theme

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final brightness = View.of(context).platformDispatcher.platformBrightness;
//     TextTheme textTheme = createTextTheme(context, "Roboto", "Inter Tight");

//     MaterialTheme theme = MaterialTheme(textTheme);
//     return MaterialApp(
//       theme: brightness == Brightness.light ? theme.light() : theme.dark(),
//       routes: {
//         '/parfums': (context) => const Parfums(),
//         '/panier': (context) => const Panier(),
//         '/bonus': (context) => const Bonus(),
//         '/carte': (context) => const Carte(),
//       },
//       home: const Home(),
//     );
//   }
// }
