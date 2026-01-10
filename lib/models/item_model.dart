import 'package:aero_glace_app/models/flavor_model.dart';

/// Représente un parfum affiché dans le panier.
///
/// Arguments :
/// - [flavor] : le titre et prix du parfum associé.
/// - [qty] : la quantité de cet item dans le panier.
class Item {
  /// Modèle de parfum associé à cet item.
  final Flavor flavor;

  /// Quantité actuelle de cet item dans le panier.
  ///
  /// Par défaut, la quantité est de 1 lors de la création d’un nouvel item.
  int qty;

  /// Crée un item du panier avec le parfum donné et la quantité optionnelle.
  Item({
    required this.flavor,
    this.qty = 1,
  });
}
