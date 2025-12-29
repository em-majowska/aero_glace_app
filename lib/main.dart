import 'package:aero_glace_app/model/hive_item_model.dart';
import 'package:flutter/material.dart';
import 'package:aero_glace_app/pages/home_page.dart';
import 'package:aero_glace_app/pages/accueil_page.dart';
import 'package:aero_glace_app/pages/parfums_page.dart';
import 'package:aero_glace_app/pages/panier_page.dart';
import 'package:aero_glace_app/pages/bonus_page.dart';
import 'package:aero_glace_app/pages/carte_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'util.dart';
// import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init the hive
  await Hive.initFlutter();

  // register adapter
  Hive.registerAdapter(HiveItemAdapter());
  // open the box
  await Hive.openBox<HiveItem>('cartBox');

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

      // provide cart model to descending widgets
      home: const HomePage(),
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
