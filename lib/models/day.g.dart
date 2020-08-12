// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayAdapter extends TypeAdapter<Day> {
  @override
  final int typeId = 3;

  @override
  Day read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Day(
      date: fields[0] as String,
      activeHabits: (fields[1] as List)?.cast<String>(),
      skips: (fields[3] as List)?.cast<String>(),
      successes: (fields[2] as List)?.cast<String>(),
      failures: (fields[4] as Map)?.cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Day obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.activeHabits)
      ..writeByte(2)
      ..write(obj.successes)
      ..writeByte(3)
      ..write(obj.skips)
      ..writeByte(4)
      ..write(obj.failures);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
