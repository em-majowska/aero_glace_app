import 'package:flutter/material.dart';

/// Crée un nouveau parfum.
///
/// @param id L'identifiant unique du parfum.
/// @param title Le nom du parfum.
/// @param description La description du parfum.
/// @param tags Les étiquettes associées au parfum.
/// @param imagePath Le chemin de l'image du parfum
///     relatif aux 'assets/images/flavors/'.
/// @param price Le prix du parfum.
/// @param meshColors Les couleurs utilisées pour l'arrière-plan du parfum.
///     4 couleurs sont attendues.
///
class Flavor {
  final int id;
  final String title;
  final String description;
  final List<String> tags;
  final String imagePath;
  final double price;
  final List<Color> meshColors;

  Flavor({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.imagePath,
    required this.price,
    required this.meshColors,
  });
}
