import 'package:aero_glace_app/i18n/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import '../model/flavor_model.dart';

final Map tags = {
  "vegan": LocaleKeys.tag_vegan.tr(),
  "sansLactose": LocaleKeys.tag_sansLactose.tr(),
  "sansGluten": LocaleKeys.tag_sansGluten.tr(),
  "bio": LocaleKeys.tag_bio.tr(),
  "cafe": LocaleKeys.tag_cafe.tr(),
  "alcoholise": LocaleKeys.tag_alcoholise.tr(),
  "cacahuetes": LocaleKeys.tag_cacahuetes.tr(),
};

final List<Flavor> defaultFlavors = [
  Flavor(
    id: 1,
    title: LocaleKeys.chocolat_title.tr(),
    description: LocaleKeys.chocolat_description.tr(),
    tags: [tags["bio"]],
    imagePath: 'chocolate.jpg',
    price: 4.50,
    meshPoints: [
      MeshGradientPoint(
        position: const Offset(1, -0.3),
        color: const Color.fromARGB(255, 199, 248, 232),
      ),
      MeshGradientPoint(
        position: const Offset(0.9, 1),
        color: const Color.fromARGB(255, 44, 9, 4),
      ),
      MeshGradientPoint(
        position: const Offset(0.2, 0.5),
        color: const Color.fromARGB(255, 131, 177, 162),
      ),
    ],
  ),

  Flavor(
    id: 2,
    title: LocaleKeys.fruit_passion_title.tr(),
    description: LocaleKeys.fruit_passion_description.tr(),
    tags: [tags["vegan"], tags["sansGluten"]],
    imagePath: 'passion-fruit.jpg',
    price: 5.00,
    meshPoints: [
      MeshGradientPoint(
        position: const Offset(0.2, 1.3),
        color: const Color.fromARGB(255, 254, 188, 186),
      ),
      MeshGradientPoint(
        position: const Offset(0.9, 0.1),
        color: const Color.fromARGB(255, 254, 188, 186),
      ),
      MeshGradientPoint(
        position: const Offset(0.5, 0),
        color: const Color.fromARGB(255, 110, 197, 255),
      ),
      MeshGradientPoint(
        position: const Offset(0.9, 1),
        color: const Color.fromARGB(255, 147, 226, 231),
      ),
    ],
  ),

  Flavor(
    id: 3,
    title: LocaleKeys.cafe_title.tr(),
    description: LocaleKeys.cafe_description.tr(),
    tags: [tags["cafe"], tags["bio"]],
    imagePath: 'coffee.jpg',
    price: 4.50,
    meshPoints: [
      MeshGradientPoint(
        position: const Offset(0.5, 0.2),
        color: const Color.fromARGB(255, 221, 125, 100),
      ),
      MeshGradientPoint(
        position: const Offset(0.8, 0.8),
        color: const Color.fromARGB(255, 221, 125, 100),
      ),
      MeshGradientPoint(
        position: const Offset(0.2, 1),
        color: const Color.fromARGB(255, 236, 203, 112),
      ),
      MeshGradientPoint(
        position: const Offset(0.8, 0.2),
        color: const Color.fromARGB(255, 236, 203, 112),
      ),
      MeshGradientPoint(
        position: const Offset(0.9, 0.5),
        color: const Color.fromARGB(255, 236, 203, 112),
      ),
    ],
  ),

  Flavor(
    id: 4,
    title: LocaleKeys.pistache_title.tr(),
    description: LocaleKeys.pistache_description.tr(),
    tags: [tags["cacahuetes"], tags["bio"]],
    imagePath: 'pistache.jpg',
    price: 5.50,
    meshPoints: [
      MeshGradientPoint(
        position: const Offset(0.3, 0.1),
        color: const Color.fromARGB(255, 255, 139, 30),
      ),
      MeshGradientPoint(
        position: const Offset(1.2, 1.2),
        color: const Color.fromARGB(255, 255, 173, 49),
      ),
      MeshGradientPoint(
        position: const Offset(0.8, 0.2),
        color: const Color.fromARGB(255, 250, 212, 44),
      ),
      MeshGradientPoint(
        position: const Offset(1, 0),
        color: const Color.fromARGB(255, 233, 196, 32),
      ),
      MeshGradientPoint(
        position: const Offset(0, 1.2),
        color: const Color.fromARGB(255, 255, 219, 161),
      ),
    ],
  ),

  Flavor(
    id: 5,
    title: LocaleKeys.citron_title.tr(),
    description: LocaleKeys.citron_description.tr(),
    tags: [tags["vegan"], tags["sansLactose"], tags["sansGluten"]],
    imagePath: 'lemon.jpg',
    price: 4.00,
    meshPoints: [
      MeshGradientPoint(
        position: const Offset(0, 0.5),
        color: const Color.fromARGB(255, 212, 161, 52),
      ),
      MeshGradientPoint(
        position: const Offset(0.7, 0.7),
        color: const Color.fromARGB(255, 193, 221, 223),
      ),
      MeshGradientPoint(
        position: const Offset(1, 0),
        color: const Color.fromARGB(255, 226, 184, 243),
      ),
      MeshGradientPoint(
        position: const Offset(0.9, 1),
        color: const Color.fromARGB(255, 235, 233, 229),
      ),
    ],
  ),

  Flavor(
    id: 6,
    title: LocaleKeys.tiramisu_title.tr(),
    description: LocaleKeys.tiramisu_description.tr(),
    tags: [tags["alcoholise"]],
    imagePath: 'strawberry.jpg',
    price: 4.50,
    meshPoints: [
      MeshGradientPoint(
        position: const Offset(0.5, 0.2),
        color: const Color.fromARGB(255, 247, 254, 255),
      ),
      MeshGradientPoint(
        position: const Offset(0.8, 0.8),
        color: const Color.fromARGB(255, 247, 254, 255),
      ),
      MeshGradientPoint(
        position: const Offset(0.2, 1),
        color: const Color.fromARGB(255, 255, 187, 110),
      ),
      MeshGradientPoint(
        position: const Offset(0.8, 0.2),
        color: const Color.fromARGB(255, 255, 139, 135),
      ),
      MeshGradientPoint(
        position: const Offset(0.9, 0.5),
        color: const Color.fromARGB(255, 255, 139, 135),
      ),
    ],
  ),

  Flavor(
    id: 7,
    title: LocaleKeys.fruit_dragon_title.tr(),
    description: LocaleKeys.fruit_dragon_description.tr(),
    tags: [tags["vegan"], tags["sansGluten"]],
    imagePath: 'dragon-fruit.jpg',
    price: 5.50,
    meshPoints: [
      MeshGradientPoint(
        position: const Offset(0.5, 0.2),
        color: const Color.fromARGB(255, 207, 194, 175),
      ),
      MeshGradientPoint(
        position: const Offset(0.8, 0.8),
        color: const Color.fromARGB(255, 207, 194, 175),
      ),
      MeshGradientPoint(
        position: const Offset(0.2, 1),
        color: const Color.fromARGB(255, 131, 177, 162),
      ),
      MeshGradientPoint(
        position: const Offset(0.8, 0.2),
        color: const Color.fromARGB(255, 131, 177, 162),
      ),
      MeshGradientPoint(
        position: const Offset(0.9, 0.5),
        color: const Color.fromARGB(255, 131, 177, 162),
      ),
    ],
  ),

  Flavor(
    id: 8,
    title: LocaleKeys.matcha_title.tr(),
    description: LocaleKeys.matcha_description.tr(),
    tags: [tags["vegan"], tags["bio"]],
    imagePath: 'matcha-mango.jpg',
    price: 5.00,
    meshPoints: [
      MeshGradientPoint(
        position: const Offset(1, 0.2),
        color: const Color.fromARGB(255, 243, 125, 6),
      ),
      MeshGradientPoint(
        position: const Offset(1, 0.8),
        color: const Color.fromARGB(255, 243, 125, 6),
      ),
      MeshGradientPoint(
        position: const Offset(-0.3, 0.4),
        color: const Color.fromARGB(255, 131, 255, 151),
      ),
      MeshGradientPoint(
        position: const Offset(0.4, 0.1),
        color: const Color.fromARGB(255, 131, 255, 151),
      ),
      MeshGradientPoint(
        position: const Offset(0.2, 0.9),
        color: const Color.fromARGB(255, 131, 255, 151),
      ),
    ],
  ),

  Flavor(
    id: 9,
    title: LocaleKeys.caramel_title.tr(),
    description: LocaleKeys.caramel_description.tr(),
    tags: [tags["sansGluten"]],
    imagePath: 'caramel.jpg',
    price: 5.50,
    meshPoints: [
      MeshGradientPoint(
        position: const Offset(0.2, 0.5),
        color: const Color.fromARGB(255, 219, 143, 0),
      ),
      MeshGradientPoint(
        position: const Offset(-0.5, 1),
        color: const Color.fromARGB(255, 252, 222, 218),
      ),
      MeshGradientPoint(
        position: const Offset(0.5, -1.3),
        color: const Color.fromARGB(255, 252, 222, 218),
      ),
      MeshGradientPoint(
        position: const Offset(0.9, 1),
        color: const Color.fromARGB(255, 252, 212, 160),
      ),
      MeshGradientPoint(
        position: const Offset(1, 0.2),
        color: const Color.fromARGB(255, 252, 212, 160),
      ),
    ],
  ),
];
