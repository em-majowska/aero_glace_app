import 'package:aero_glace_app/util/next_day.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:aero_glace_app/data/default_flavors.dart';
import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:aero_glace_app/model/hive_item_model.dart';
import 'package:aero_glace_app/model/item_model.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  // get hive box
  late final Box _cartBox;
  final List<Flavor> _flavors = defaultFlavors;
  double total = 0;
  late int _discount = 0;
  DateTime _date = DateTime.now();

  // getters
  int get discount => _discount;
  DateTime get date => _date;
  List<Item> get items {
    final items = _filterItems();
    return items.map((item) {
      final flavor = _flavors.firstWhere((f) => f.id == item.flavorId);
      return Item(flavor: flavor, qty: item.qty);
    }).toList();
  }

  Cart() {
    _cartBox = Hive.box('cartBox');
    _loadCart();
  }

  // load cart from Hive
  void _loadCart() {
    final cart = _cartBox.get('cart');
    var isDiscountValid =
        true; // fetch data from hive if discount is still valid

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

  void _updateCart() {
    _cartBox.put('cart', {
      'discount': _discount,
      'date': _date.toIso8601String(),
    });

    notifyListeners();
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
    }

    notifyListeners();
  }

  // discard all items of the same flavor
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
  int getItemQuantity(int flavorId) {
    try {
      return _cartBox.values
          .firstWhere((item) => item.flavorId == flavorId)
          .qty;
    } catch (e) {
      return 0;
    }
  }

  // get total quantity
  int get totalQuantity =>
      _filterItems().fold(0, (sum, item) => sum + item.qty);

  // TODO add item price to item_tile
  // get price per item
  double getItemPrice(Flavor flavor) {
    try {
      final item = _cartBox.values.firstWhere(
        (item) => item.flavorId == flavor.id,
      );
      return item.qty * flavor.price;
    } catch (e) {
      return 0;
    }
  }

  // get total  price
  double get totalPrice {
    total = _filterItems().fold(0.00, (sum, item) {
      final flavor = _flavors.firstWhere((f) => f.id == item.flavorId);
      return sum + (flavor.price * item.qty);
    });

    return total;
  }

  double get totalPriceDiscounted {
    return (_discount != 0) ? total - (total * (discount / 100)) : 0.0;
  }

  double get savings {
    return totalPrice * (discount / 100);
  }

  void setDiscount(int result, DateTime? now) {
    _discount = result;
    _date = (now == null) ? DateTime.now() : now;
    _updateCart();
  }

  // filter items from hivebox, exclude discount
  Iterable<HiveItem> _filterItems() {
    return _cartBox.values.whereType<HiveItem>();
  }
}
