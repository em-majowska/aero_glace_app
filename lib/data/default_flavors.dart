import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import '../features/flavors/flavor_model.dart';

final List<Flavor> defaultFlavors = [
  Flavor(
    title: 'Chocolat Supernova',
    description:
        'Explosion de chocolat noir belge avec des éclats de cacao torréfié.',
    tags: ['organic'],
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
    title: 'Fruit de la Passion Orion',
    description:
        'Fruit de la passion exotique avec une touche de vanille stellaire.',
    tags: ['vegan', 'glutenFree'],
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
    title: 'Café Nébuleuse',
    description: 'Espresso italien intense avec des notes de caramel cosmique.',
    tags: ['organic'],
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
    title: 'Pistache Andromède',
    description: 'Pistache de Sicile premium avec un voile de miel astral.',
    tags: ['containsPeanuts', 'organic'],
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
    title: 'Citron Solaire',
    description: 'Citron de Menton acidulé avec du zeste cristallisé.',
    tags: ['vegan', 'lactoseFree', 'glutenFree'],
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
    title: 'Tiramisu Saturne Fraise',
    description:
        'Tiramisu onctueux aux fraises tournoyant autour des anneaux de Saturne.',
    tags: ['containsAlcohol'],
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
    title: 'Fruit du Dragon Cosmos',
    description: 'Pitaya rose vibrante cueilli aux confins du cosmos.',
    tags: ['vegan', 'glutenFree'],
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
    title: 'Matcha Aurore Mangue',
    description:
        'Thé matcha de Kyoto fusionné avec la mangue dans un tourbillon nébuleux.',
    tags: ['vegan', 'organic'],
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
    title: 'Caramel Stellaire',
    description:
        'Caramel au beurre salé de Bretagne, glacé comme les plaines de Pluton.',
    tags: ['glutenFree'],
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
