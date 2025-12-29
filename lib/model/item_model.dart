import 'package:aero_glace_app/model/flavor_model.dart';

class Item {
  final Flavor flavor;
  int qty;

  Item({
    required this.flavor,
    this.qty = 1,
  });
}
