// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_widget.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InputWidgetAdapter extends TypeAdapter<InputWidget> {
  @override
  final int typeId = 4;

  @override
  InputWidget read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InputWidget(
      set: fields[0] as Round?,
    );
  }

  @override
  void write(BinaryWriter writer, InputWidget obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.set);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InputWidgetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
