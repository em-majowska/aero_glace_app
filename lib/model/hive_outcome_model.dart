import 'package:hive_flutter/hive_flutter.dart';

part 'hive_outcome_model.g.dart';

@HiveType(typeId: 1)
class HiveOutcome extends HiveObject {
  @HiveField(0)
  int value;

  @HiveField(1)
  final String type;

  HiveOutcome({
    required this.value,
    required this.type,
  });
}

// generate with 'dart run build_runner build' command
