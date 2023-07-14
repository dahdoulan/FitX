// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutUserAdapter extends TypeAdapter<WorkoutUser> {
  @override
  final int typeId = 6;

  @override
  WorkoutUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutUser()
      .._email = fields[0] as String
      .._password = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, WorkoutUser obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._email)
      ..writeByte(1)
      ..write(obj._password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
