import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';

class CartProvider extends ChangeNotifier {
  // hive
  // final Box<Flavor> _cartBox;

  // list of items in user cart
  List<Flavor> userCart = [];

  // CartProvider(this._cartBox) {
  //   _loadCart();
  // }

  // load cart from Hive
  // void _loadCart() {
  //   _userCart = _cartBox.values.toList();
  //   notifyListeners();
  // }

  // check if item already exists in cart
  // Flavor? _findItem(Flavor flavor) {
  //   try {
  //     return _userCart.firstWhere((item) => item.id == flavor.id);
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // get cart
  List<Flavor> getUserCart() {
    return userCart;
  }

  // add items to cart
  // void addItemToCart(Flavor flavor) {
  //   Flavor? existingFlavor = _findItem(flavor);
  //   if (existingFlavor != null) {
  //     flavor.qty++;
  //   } else {
  //     _userCart.add(flavor);
  //   }
  //   // flavor.qty++;
  //   notifyListeners();
  // }

  // // remove item from cart
  // void removeItemFromCart(Flavor flavor) {
  //   if (flavor.qty > 1) {
  //     _userCart.remove(flavor);
  //   } else {
  //     flavor.qty--;
  //   }
  //   notifyListeners();
  // }

  void addItemToCart(Flavor flavor) {
    if (!userCart.contains(flavor)) {
      userCart.add(flavor);
    }
    flavor.qty++;
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(Flavor flavor) {
    if (flavor.qty == 1) {
      userCart.remove(flavor);
    }
    flavor.qty--;
    notifyListeners();
  }

  // get total quantity
  int getQuantity() {
    return userCart.fold(0, (sum, flavor) => sum + flavor.qty);
  }

  double getTotalValue() {
    return userCart.fold(
      0,
      (sum, flavor) => sum + (flavor.price * flavor.qty),
    );
  }
}
