// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_outcome_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveOutcomeAdapter extends TypeAdapter<HiveOutcome> {
  @override
  final int typeId = 1;

  @override
  HiveOutcome read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveOutcome(
      value: fields[0] as int,
      type: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveOutcome obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveOutcomeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
