// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_fidelity_level.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveFidelityLevelAdapter extends TypeAdapter<HiveFidelityLevel> {
  @override
  final int typeId = 2;

  @override
  HiveFidelityLevel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveFidelityLevel(
      value: fields[0] as int,
      minPoints: fields[1] as int,
      maxPoints: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveFidelityLevel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.minPoints)
      ..writeByte(2)
      ..write(obj.maxPoints);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveFidelityLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
