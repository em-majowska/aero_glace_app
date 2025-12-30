import 'package:hive_flutter/hive_flutter.dart';
import 'package:aero_glace_app/data/default_flavors.dart';
import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:aero_glace_app/model/hive_item_model.dart';
import 'package:aero_glace_app/model/item_model.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  // get hive box
  Box<HiveItem> get _cartBox => Hive.box<HiveItem>('cartBox');
  final List<Flavor> _flavors = defaultFlavors;
  double _discount = 0;

  Cart() {
    _loadCart();
  }

  // load cart from Hive
  void _loadCart() {
    notifyListeners();
  }

  List<Item> get items {
    return _cartBox.values.map((item) {
      final flavor = _flavors.firstWhere((f) => f.id == item.flavorId);
      return Item(flavor: flavor, qty: item.qty);
    }).toList();
  }

  // add item
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

  // remove item
  void removeItem(Flavor flavor) {
    final existingItem = _findCartItem(flavor.id);
    if (existingItem != null) {
      if (existingItem.qty > 1) {
        existingItem.qty--;
        _cartBox.put(existingItem.key, existingItem);
      } else {
        _cartBox.delete(existingItem.key);
      }
      notifyListeners();
    }
  }

  void discardItem(Flavor flavor) {
    final existingItem = _findCartItem(flavor.id);
    if (existingItem != null) {
      _cartBox.delete(existingItem.key);
    }
    notifyListeners();
  }

  // empty the cart
  void discardAllItems() {
    _cartBox.clear();
    notifyListeners();
  }

  // check if item already exists and get it
  HiveItem? _findCartItem(int flavorId) {
    try {
      return _cartBox.values.firstWhere(
        (item) => item.flavorId == flavorId,
      );
    } catch (e) {
      return null;
    }
  }

  // get quantity per item
  int getItemQuantity(int flavorId) =>
      _cartBox.values.firstWhere((item) => item.flavorId == flavorId).qty;

  // get total quantity
  int get totalQuantity =>
      _cartBox.values.fold(0, (sum, item) => sum + item.qty);

  // TODO add item price to item_tile
  // get price per item
  double getItemPrice(Flavor flavor) {
    final item = _cartBox.values.firstWhere(
      (item) => item.flavorId == flavor.id,
    );
    return item.qty * flavor.price;
  }

  // get total  price
  double get totalPrice {
    double total = _cartBox.values.fold(0.00, (sum, item) {
      final flavor = _flavors.firstWhere((f) => f.id == item.flavorId);
      return sum + (flavor.price * item.qty);
    });

    if (_discount != 0) {
      total = total * (1 - discount);
    }
    return total;
  }

  void setDiscount(String result) {
    _discount = int.parse(result.substring(0, 2)) / 100;
    notifyListeners();
  }

  double get discount => _discount;
}
