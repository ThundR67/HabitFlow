// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CycleAdapter extends TypeAdapter<Cycle> {
  @override
  final int typeId = 4;

  @override
  Cycle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cycle(
      start: fields[0] as String,
      end: fields[1] as String,
      review: fields[2] as String,
      days: (fields[3] as Map)?.cast<String, Day>(),
    );
  }

  @override
  void write(BinaryWriter writer, Cycle obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.start)
      ..writeByte(1)
      ..write(obj.end)
      ..writeByte(2)
      ..write(obj.review)
      ..writeByte(3)
      ..write(obj.days);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) {
    print(other);
    return identical(this, other) ||
        other is CycleAdapter &&
            runtimeType == other.runtimeType &&
            typeId == other.typeId;
  }
}
