// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_fortune_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveFortuneResultAdapter extends TypeAdapter<HiveFortuneResult> {
  @override
  final int typeId = 1;

  @override
  HiveFortuneResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveFortuneResult(
      value: fields[0] as int,
      type: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveFortuneResult obj) {
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
      other is HiveFortuneResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
