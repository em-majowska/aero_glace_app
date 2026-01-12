import 'package:aero_glace_app/features/about/hero_animated_layer.dart';
import 'package:aero_glace_app/features/about/hero_elements.dart';
import 'package:aero_glace_app/utils/context_extensions.dart';
import 'package:aero_glace_app/widgets/animate_visible.dart';
import 'package:aero_glace_app/widgets/app_bar.dart';
import 'package:blobs/blobs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:aero_glace_app/widgets/background.dart';
import 'package:text_gradiate/text_gradiate.dart';

/// Page “À propos” de l’application.
///
/// Affiche les informations sur l’entreprise les
/// éléments graphiques animés.
class AboutPage extends StatefulWidget {
  /// Crée la page "À propos"
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar().appBar(context, context.tr('aero_glace')),
      body: Stack(
        children: [
          // Arrière-plan principal
          const MyBackground(assetPath: 'background.jpg'),

          // Blobs décoratifs
          HeroElement().blob_1(context),
          HeroElement().blob_2(context),
          HeroElement().blob_3(context),
          HeroElement().blob_4(context),

          CustomScrollView(
            slivers: [
              SliverFillViewport(
                delegate: SliverChildBuilderDelegate(
                  childCount: 1,
                  (context, index) => const HeroElements(),
                ),
              ),

              // Section de texte et images illustratives
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 1,
                  (context, index) {
                    final content = [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          right: 16,
                          left: 16,
                          bottom: 0,
                        ),
                        child: Column(
                          spacing: 48,
                          children: [
                            // Texte 1
                            AnimateOnVisible(
                              child: Text.rich(
                                TextSpan(
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge,
                                  text: context.tr('about_first.start'),
                                  children: [
                                    TextSpan(
                                      text: context.tr('aero_glace'),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    TextSpan(
                                      text: context.tr('about_first.end'),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Image décorative côté droit (blob)
                            AnimateOnVisible(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: ClipPath(
                                    clipper: BlobClipper(
                                      edgesCount: 20,
                                      minGrowth: 7,
                                    ),
                                    child: Image.asset(
                                      'assets/images/flavors/dragon-fruit.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Texte 2
                            AnimateOnVisible(
                              child: Text(
                                context.tr('about_second'),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),

                            // Image décorative côté gauche (blob)
                            AnimateOnVisible(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: ClipPath(
                                    clipper: BlobClipper(
                                      edgesCount: 20,
                                      minGrowth: 7,
                                    ),
                                    child: Image.asset(
                                      'assets/images/flavors/matcha-mango.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Texte 3
                            AnimateOnVisible(
                              child: Text(
                                context.tr('about_third'),
                                style: context.textTheme.bodyLarge,
                                textAlign: TextAlign.center,
                              ),
                            ),

                            // Titres en gradient
                            Column(
                              spacing: 16,
                              children: [
                                AnimateOnVisible(
                                  child: TextGradiate(
                                    text: Text(
                                      context.tr('headline_1'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    colors: [
                                      Colors.purpleAccent.shade100,
                                      Colors.indigoAccent.shade200,
                                    ],
                                    gradientType: GradientType.linear,
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                AnimateOnVisible(
                                  child: Text(
                                    context.tr('and'),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineMedium,
                                  ),
                                ),
                                AnimateOnVisible(
                                  child: TextGradiate(
                                    text: Text(
                                      context.tr('headline_2'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    colors: [
                                      Colors.indigoAccent.shade100,
                                      Colors.purpleAccent.shade200,
                                    ],
                                    gradientType: GradientType.linear,
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ],
                            ),

                            // Image décorative finale
                            SizedBox(
                              width: 200,
                              child: Image.asset(
                                'assets/images/ice-cream-hand.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ];
                    return content[index];
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
