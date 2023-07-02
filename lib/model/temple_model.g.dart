// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temple_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MandirAdapter extends TypeAdapter<Mandir> {
  @override
  final int typeId = 0;

  @override
  Mandir read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mandir(
      name: fields[0] as String,
      address: fields[1] as String,
      shortDescription: fields[2] as String,
      priest: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Mandir obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.shortDescription)
      ..writeByte(3)
      ..write(obj.priest);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MandirAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
