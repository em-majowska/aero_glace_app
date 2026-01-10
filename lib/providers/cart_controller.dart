import 'package:aero_glace_app/data/flavors_list.dart';
import 'package:aero_glace_app/utils/next_day.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:aero_glace_app/models/flavor_model.dart';
import 'package:aero_glace_app/models/hive_item_model.dart';
import 'package:aero_glace_app/models/item_model.dart';
import 'package:flutter/material.dart';

/// Contrôleur pour gérer le panier de l'utilisateur.
///
/// Ce contrôleur utilise **Hive** pour persister les items [Item] ajoutés au panier
/// et gère également les réductions et la date d'expirations de celles-ci.
class CartController extends ChangeNotifier {
  /// Boîte **Hive** utilisée pour stocker les items du panier et la réduction.
  late final Box _cartBox;

  /// Réduction actuelle appliquée sur le panier.
  late int _discount = 0;

  /// Date associée à la dernière réduction appliquée.
  DateTime _date = DateTime.now();

  /// Liste des parfums disponibles.
  final List<Flavor> _flavors = getFlavors();

  /// Liste des items actuellement dans le panier.
  List<Item> items = [];

  /// Retourne la réduction actuelle.
  int get discount => _discount;

  /// Retourne la liste des items du panier avec leur quantité et les objets [Flavor] correspondants.
  List<Item> getItems() {
    return _filterItems().map((item) {
      final flavor = _flavors.firstWhere((f) => f.id == item.flavorId);
      return Item(flavor: flavor, qty: item.qty);
    }).toList();
  }

  /// Crée une instance de [CartController] et initialise le panier depuis **Hive**.
  CartController() {
    _cartBox = Hive.box('cartBox');
    _loadCart();
    _updateItems();
  }

  /// Met à jour la liste locale [items] à partir de la boîte Hive.
  void _updateItems() {
    items = _filterItems().map((hiveItem) {
      final flavor = _flavors.firstWhere((f) => f.id == hiveItem.flavorId);
      return Item(flavor: flavor, qty: hiveItem.qty);
    }).toList();
  }

  /// Charge le panier depuis la boîte **Hive** et vérifie la validité de la réduction.
  void _loadCart() {
    final cart = _cartBox.get('cart');
    var isDiscountValid = true;

    if (cart != null) {
      _discount = cart['discount'] ?? _discount;
      _date = DateTime.tryParse(cart['date']) ?? _date;

      if (isNextDay(_date)) {
        setDiscount(0, _date);
        isDiscountValid = false;
      }
    }

    if (isDiscountValid) notifyListeners();
  }

  /// Met à jour la boîte **Hive** avec les informations actuelles du panier et de la réduction.
  void _updateCart() {
    _cartBox.put('cart', {
      'discount': _discount,
      'date': _date.toIso8601String(),
    });

    notifyListeners();
  }

  /// Ajoute un item au panier ou incrémente la quantité si déjà présent.
  ///
  /// [flavor] : le parfum à ajouter au panier.
  void addItem(Flavor flavor) {
    final existingItem = _findCartItem(flavor.id);

    if (existingItem != null) {
      existingItem.qty++;
      _cartBox.put(existingItem.key, existingItem);
    } else {
      _cartBox.add(HiveItem(flavorId: flavor.id));
    }

    notifyListeners();
  }

  /// Supprime un item du panier ou décrémente la quantité si plus d'un.
  ///
  /// [flavor] : le parfum à supprimer.
  void removeItem(Flavor flavor) {
    final existingItem = _findCartItem(flavor.id);

    if (existingItem != null) {
      if (existingItem.qty > 1) {
        existingItem.qty--;
        _cartBox.put(existingItem.key, existingItem);
      } else {
        _cartBox.delete(existingItem.key);
      }
    }

    notifyListeners();
  }

  /// Supprime tous les items d'un parfum spécifique du panier par [Slidable].
  ///
  /// [flavor] : le parfum à supprimer complètement.
  void discardItem(Flavor flavor) {
    final existingItem = _findCartItem(flavor.id);

    if (existingItem != null) {
      _cartBox.delete(existingItem.key);
    }

    notifyListeners();
  }

  /// Vide complètement le panier.
  void discardAllItems() {
    final keysToDelete = _cartBox.keys.where((key) {
      final value = _cartBox.get(key);
      return value is HiveItem;
    }).toList();

    for (final key in keysToDelete) {
      _cartBox.delete(key);
    }

    _updateItems();
    notifyListeners();
  }

  /// Cherche un item dans le panier par [flavorId].
  ///
  /// Retourne un [HiveItem] si trouvé, sinon null.
  HiveItem? _findCartItem(int flavorId) {
    try {
      return _cartBox.values.firstWhere(
        (item) => item.flavorId == flavorId,
      );
    } catch (e) {
      return null;
    }
  }

  /// Retourne la quantité d'un item dans le panier.
  ///
  /// [flavorId] : l'identifiant d'un parfum dont la quantité doit être calculé.
  int getItemQuantity(int flavorId) {
    try {
      return _cartBox.values
          .firstWhere((item) => item.flavorId == flavorId)
          .qty;
    } catch (e) {
      return 0;
    }
  }

  /// Retourne la quantité totale d'items dans le panier.
  int get totalQuantity =>
      _filterItems().fold(0, (sum, item) => sum + item.qty);

  /// Retourne le prix total d'un item dans le panier.
  ///
  /// [flavor] : le parfum dont le prix doit être calculé.
  double getItemPrice(Flavor flavor) {
    try {
      final item = _filterItems().firstWhere(
        (item) => item.flavorId == flavor.id,
      );
      return item.qty * flavor.price;
    } catch (e) {
      return 0;
    }
  }

  /// Retourne le prix total du panier sans réduction.
  double getTotalPrice() {
    return getItems().fold(
      0,
      (sum, item) => sum + (item.flavor.price * item.qty),
    );
  }

  /// Retourne le prix total du panier après application de la réduction.
  ///
  /// [total] : prix total avant réduction.
  double getTotalPriceDiscounted(double total) {
    return (_discount != 0) ? total - (total * (_discount / 100)) : total;
  }

  /// Calcule les économies réalisées en appliquant la réduction.
  ///
  /// [total] : prix total avant réduction.
  double getSavings(double total) => total * (_discount / 100);

  /// Définit la réduction et la date associée.
  ///
  /// [result] : pourcentage de réduction à appliquer.
  /// [now] : date de l'application de la réduction.
  void setDiscount(int result, DateTime? now) {
    _discount = result;
    _date = now ?? DateTime.now();
    _updateCart();
  }

  /// Retourne tous les items de la boîte Hive (exclut la réduction et la date associée).
  Iterable<HiveItem> _filterItems() {
    return _cartBox.values.whereType<HiveItem>();
  }
}
