// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalAdapter extends TypeAdapter<Goal> {
  @override
  final int typeId = 2;

  @override
  Goal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Goal(
      activeDays: (fields[0] as List)?.cast<int>(),
      times: fields[1] as int,
      unit: fields[2] as String,
      notificationTimes: (fields[3] as List)?.cast<TimeOfDay>(),
    );
  }

  @override
  void write(BinaryWriter writer, Goal obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.activeDays)
      ..writeByte(1)
      ..write(obj.times)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.notificationTimes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
