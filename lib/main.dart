import 'package:flutter/material.dart';
import 'package:aero_glace_app/pages/welcome_page.dart';
import 'package:aero_glace_app/pages/accueil.dart';
import 'package:aero_glace_app/pages/parfums.dart';
import 'package:aero_glace_app/pages/panier.dart';
import 'package:aero_glace_app/pages/bonus.dart';
import 'package:aero_glace_app/pages/carte.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'util.dart';
// import 'theme.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  //open the box
  await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   primarySwatch: Colors.yellow,
      // ),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: Colors.indigo,
      //     brightness: Brightness.light,
      //   ),
      // ),
      // textTheme: TextTheme(
      //   headlineMedium: GoogleFonts.inter(
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      // ),
      routes: {
        '/accueil': (context) => const Accueil(),
        '/parfums': (context) => const Parfums(),
        '/panier': (context) => const Panier(),
        '/bonus': (context) => const Bonus(),
        '/carte': (context) => const Carte(),
      },
      home: const WelcomePage(),
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
