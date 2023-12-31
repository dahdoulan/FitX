// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoundAdapter extends TypeAdapter<Round> {
  @override
  final int typeId = 3;

  @override
  Round read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Round(
      reptitions: fields[1] as int,
      weight: fields[2] as double,
      setNumber: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Round obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.setNumber)
      ..writeByte(1)
      ..write(obj.reptitions)
      ..writeByte(2)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoundAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
