import 'package:aero_glace_app/model/hive_item_model.dart';
import 'package:aero_glace_app/model/hive_level_model.dart';
import 'package:aero_glace_app/model/hive_outcome_model.dart';
import 'package:flutter/material.dart';
import 'package:aero_glace_app/pages/home_page.dart';
import 'package:aero_glace_app/pages/accueil_page.dart';
import 'package:aero_glace_app/pages/parfums_page.dart';
import 'package:aero_glace_app/pages/panier_page.dart';
import 'package:aero_glace_app/pages/bonus_page.dart';
import 'package:aero_glace_app/pages/carte_page.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'util.dart';
// import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init the hive
  await Hive.initFlutter();

  // register adapter
  Hive.registerAdapter(HiveItemAdapter());
  Hive.registerAdapter(HiveOutcomeAdapter());
  Hive.registerAdapter(HiveLevelAdapter());
  // open the box
  await Hive.openBox('cartBox');
  await Hive.openBox('fortuneBox');

  // i18n
  // WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();

  // runApp(
  //   EasyLocalization(
  //     supportedLocales: const [Locale('fr'), Locale('ja')],
  //     path: 'assets/i18n',
  //     fallbackLocale: const Locale('fr'),
  //     child: const MyApp(),
  //   ),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final FlutterI18nDelegate flutterI18nDelegate;

  // const MyApp({super.key, required this.flutterI18nDelegate});
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
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      locale: const Locale('fr'),
      supportedLocales: const [
        Locale('fr'),
        Locale('ja'),
      ],
      // WidgetsFlutterBinding.ensureInitialized();
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            useCountryCode: false,
            fallbackFile: 'fr',
            basePath: 'assets/i18n',
          ),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
