import 'package:flutter/material.dart';

/// Représente un nouveau parfum.
///
/// Contient toutes les informations nécessaires pour l'affichage et la gestion
/// d'un parfum dans le catalogue et le panier.
///
/// Arguments :
/// - [id] : Identifiant unique du parfum.
/// - [title] : Le nom du parfum.
/// - [description] : La description du parfum.
/// - [tags] : Liste des étiquettes associées au parfum.
/// - [imagePath] : Chemin de l'image du parfum relatif au dossier
///     `assets/images/flavors/`.
/// - [meshColors] : Couleurs utilisées pour le fond en dégradé maillé
///     du parfum (4 requis).
class Flavor {
  /// Identifiant unique du parfum.
  final int id;
  final String title;
  final String description;

  /// Liste des étiquettes associées au parfum (ex: "vegan", "bio").
  ///
  /// Chaque valeur correspond à une clé de traduction
  /// (ex. `tags.vegan`, `tags.sansGluten`).
  ///
  /// Exemples de valeurs possibles :
  /// `['vegan', 'sansGluten', 'bio', 'cafe', 'cacahuetes', 'sansLactose', 'alcoolise']`
  final List<String> tags;

  /// Chemin de l'image du parfum relatif au dossier `assets/images/flavors/`.
  final String imagePath;
  final double price;

  /// Couleurs utilisées pour le fond en dégradé maillé du parfum.
  ///
  /// Quatre couleurs sont attendues pour l'animation du mesh gradient.
  final List<Color> meshColors;

  /// Crée un parfum avec toutes les propriétés requises.
  ///
  /// Tous les champs sont obligatoires.
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
