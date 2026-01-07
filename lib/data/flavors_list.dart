import 'package:aero_glace_app/i18n/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../model/flavor_model.dart';

Map<String, String> getTags(BuildContext context) => {
  "vegan": context.tr('tag.vegan'),
  "sansLactose": context.tr('tag.sansLactose'),
  "sansGluten": context.tr('tag.sansGluten'),
  "bio": context.tr('tag.bio'),
  "cafe": context.tr('tag.cafe'),
  "alcoholise": context.tr('tag.alcoholise'),
  "cacahuetes": context.tr('tag.cacahuetes'),
};

List<Flavor> getFlavors(BuildContext context) => [
  Flavor(
    id: 1,
    title: LocaleKeys.chocolat_title.tr(),
    description: LocaleKeys.chocolat_description.tr(),
    tags: [getTags(context)["bio"]!],
    imagePath: 'chocolate.jpg',
    price: 4.50,
    meshColors: [
      const Color.fromARGB(255, 199, 248, 232),
      const Color.fromARGB(255, 199, 248, 232),
      const Color.fromARGB(255, 90, 50, 44),
      const Color.fromARGB(255, 131, 177, 162),
    ],
  ),

  Flavor(
    id: 2,
    title: LocaleKeys.fruit_passion_title.tr(),
    description: LocaleKeys.fruit_passion_description.tr(),
    tags: [getTags(context)["vegan"]!, getTags(context)["sansGluten"]!],
    imagePath: 'passion-fruit.jpg',
    price: 5.00,
    meshColors: [
      const Color.fromARGB(255, 255, 183, 50),
      const Color.fromARGB(255, 253, 255, 237),
      const Color.fromARGB(255, 253, 255, 237),
      const Color.fromARGB(255, 177, 0, 118),
    ],
  ),

  Flavor(
    id: 3,
    title: LocaleKeys.cafe_title.tr(),
    description: LocaleKeys.cafe_description.tr(),
    tags: [getTags(context)["cafe"]!, getTags(context)["bio"]!],
    imagePath: 'coffee.jpg',
    price: 4.50,
    meshColors: [
      const Color.fromARGB(255, 167, 132, 124),
      const Color.fromARGB(255, 167, 132, 124),
      const Color.fromARGB(255, 255, 235, 221),
      const Color.fromARGB(255, 255, 235, 221),
    ],
  ),

  Flavor(
    id: 4,
    title: LocaleKeys.pistache_title.tr(),
    description: LocaleKeys.pistache_description.tr(),
    tags: [getTags(context)["cacahuetes"]!, getTags(context)["bio"]!],
    imagePath: 'pistache.jpg',
    price: 5.50,
    meshColors: [
      const Color.fromARGB(255, 228, 255, 165),
      const Color.fromARGB(255, 255, 234, 141),
      const Color.fromARGB(255, 213, 255, 114),
      const Color.fromARGB(255, 255, 173, 49),
    ],
  ),

  Flavor(
    id: 5,
    title: LocaleKeys.citron_title.tr(),
    description: LocaleKeys.citron_description.tr(),
    tags: [
      getTags(context)["vegan"]!,
      getTags(context)["sansLactose"]!,
      getTags(context)["sansGluten"]!,
    ],
    imagePath: 'lemon.jpg',
    price: 4.00,
    meshColors: [
      const Color.fromARGB(255, 235, 185, 255),
      const Color.fromARGB(255, 252, 255, 99),
      const Color.fromARGB(255, 246, 255, 163),
      const Color.fromARGB(255, 228, 255, 76),
    ],
  ),

  Flavor(
    id: 6,
    title: LocaleKeys.tiramisu_title.tr(),
    description: LocaleKeys.tiramisu_description.tr(),
    tags: [getTags(context)["alcoholise"]!],
    imagePath: 'strawberry.jpg',
    price: 4.50,
    meshColors: [
      const Color.fromARGB(255, 247, 254, 255),
      const Color.fromARGB(255, 247, 254, 255),
      const Color.fromARGB(255, 255, 218, 177),
      const Color.fromARGB(255, 255, 104, 99),
    ],
  ),

  Flavor(
    id: 7,
    title: LocaleKeys.fruit_dragon_title.tr(),
    description: LocaleKeys.fruit_dragon_description.tr(),
    tags: [getTags(context)["vegan"]!, getTags(context)["sansGluten"]!],
    imagePath: 'dragon-fruit.jpg',
    price: 5.50,
    meshColors: [
      const Color.fromARGB(255, 252, 91, 179),
      const Color.fromARGB(255, 255, 134, 225),
      const Color.fromARGB(255, 254, 249, 255),
      const Color.fromARGB(255, 180, 180, 180),
    ],
  ),

  Flavor(
    id: 8,
    title: LocaleKeys.matcha_title.tr(),
    description: LocaleKeys.matcha_description.tr(),
    tags: [getTags(context)["vegan"]!, getTags(context)["bio"]!],
    imagePath: 'matcha-mango.jpg',
    price: 5.00,
    meshColors: [
      const Color.fromARGB(255, 252, 156, 60),
      const Color.fromARGB(255, 252, 156, 60),
      const Color.fromARGB(255, 173, 255, 187),
      const Color.fromARGB(255, 131, 255, 151),
    ],
  ),

  Flavor(
    id: 9,
    title: LocaleKeys.caramel_title.tr(),
    description: LocaleKeys.caramel_description.tr(),
    tags: [getTags(context)["sansGluten"]!],
    imagePath: 'caramel.jpg',
    price: 5.50,
    meshColors: [
      const Color.fromARGB(255, 219, 143, 0),
      const Color.fromARGB(255, 252, 222, 218),
      const Color.fromARGB(255, 252, 212, 160),
      const Color.fromARGB(255, 252, 212, 160),
    ],
  ),
];
