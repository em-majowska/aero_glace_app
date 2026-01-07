import 'package:hive_flutter/hive_flutter.dart';

part 'hive_fidelity_level.g.dart';

@HiveType(typeId: 2)
class HiveFidelityLevel extends HiveObject {
  @HiveField(0)
  final int value;
  @HiveField(1)
  final int minPoints;
  @HiveField(2)
  final int maxPoints;

  HiveFidelityLevel({
    required this.value,
    required this.minPoints,
    required this.maxPoints,
  });
}

// generate with 'dart run build_runner build' command
