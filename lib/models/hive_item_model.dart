import 'package:hive_flutter/hive_flutter.dart';

// generate with 'dart run build_runner build' command
part 'hive_item_model.g.dart';

/// Représente un item sauvegardé dans la boîte **Hive** pour le panier.
///
/// Chaque [HiveItem] correspond à un parfum ajouté au panier avec sa quantité.
/// Cette classe est utilisée pour persister les données du panier entre les sessions.
///
/// Arguments :
/// - [flavorId] : identifiant du parfum correspondant.
/// - [qty] : quantité initiale de cet item (par défaut 1).
@HiveType(typeId: 0)
class HiveItem extends HiveObject {
  /// Identifiant du parfum associé à cet item.
  @HiveField(0)
  final int flavorId;

  /// Quantité de ce parfum dans le panier.
  @HiveField(1)
  int qty;

  /// Crée un nouvel item pour le panier.
  HiveItem({
    required this.flavorId,
    this.qty = 1,
  });
}
