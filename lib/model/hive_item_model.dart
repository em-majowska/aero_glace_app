import 'package:hive_flutter/hive_flutter.dart';

part 'hive_item_model.g.dart';

@HiveType(typeId: 0)
class HiveItem extends HiveObject {
  @HiveField(0)
  final int flavorId;

  @HiveField(1)
  int qty;

  HiveItem({
    required this.flavorId,
    this.qty = 1,
  });
}

// generate with 'dart run build_runner build' command
