import 'package:hive_flutter/hive_flutter.dart';

part 'hive_fortune_result.g.dart';

@HiveType(typeId: 1)
class HiveFortuneResult extends HiveObject {
  @HiveField(0)
  int value;

  @HiveField(1)
  final String type;

  HiveFortuneResult({
    required this.value,
    required this.type,
  });
}

// generate with 'dart run build_runner build' command
