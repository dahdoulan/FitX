// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_provider.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutProviderAdapter extends TypeAdapter<WorkoutProvider> {
  @override
  final int typeId = 2;

  @override
  WorkoutProvider read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutProvider()
      .._exercises = (fields[0] as List).cast<Exercise>()
      .._favorites = (fields[1] as List).cast<Favorite>()
      .._queryWorkouts = (fields[2] as List?)?.cast<Round>()
      ..screens = (fields[5] as List).cast<dynamic>()
      ..screenIndex = fields[6] as int;
  }

  @override
  void write(BinaryWriter writer, WorkoutProvider obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj._exercises)
      ..writeByte(1)
      ..write(obj._favorites)
      ..writeByte(2)
      ..write(obj._queryWorkouts)
      ..writeByte(5)
      ..write(obj.screens)
      ..writeByte(6)
      ..write(obj.screenIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutProviderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
