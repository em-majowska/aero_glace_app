import 'package:aero_glace_app/generated/codegen_loader.g.dart';
import 'package:aero_glace_app/model/hive_item_model.dart';
import 'package:aero_glace_app/model/hive_fidelity_level.dart';
import 'package:aero_glace_app/model/hive_fortune_result.dart';
import 'package:flutter/material.dart';
import 'package:aero_glace_app/pages/home_page.dart';
import 'package:aero_glace_app/pages/about_page.dart';
import 'package:aero_glace_app/pages/flavors_page.dart';
import 'package:aero_glace_app/pages/cart_page.dart';
import 'package:aero_glace_app/pages/bonus_page.dart';
import 'package:aero_glace_app/pages/map_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'util/scaffold_messenger.dart';
// import 'util.dart';
// import 'theme.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  // init the hive
  await Hive.initFlutter();

  // register adapter
  Hive.registerAdapter(HiveItemAdapter());
  Hive.registerAdapter(HiveFortuneResultAdapter());
  Hive.registerAdapter(HiveFidelityLevelAdapter());
  // open the box
  await Hive.openBox('cartBox');
  await Hive.openBox('fortuneBox');

  runApp(
    EasyLocalization(
      path: 'assets/i18n',
      supportedLocales: const [Locale('fr'), Locale('ja')],
      fallbackLocale: const Locale('fr'),
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
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
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      routes: {
        '/accueil': (context) => const AboutPage(),
        '/parfums': (context) => const FlavorsPage(),
        '/panier': (context) => const CartPage(),
        '/bonus': (context) => const BonusPage(),
        '/carte': (context) => const MapPage(),
      },

      home: Builder(
        builder: (context) {
          return const HomePage();
        },
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
