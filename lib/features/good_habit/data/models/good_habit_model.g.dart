// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'good_habit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoodHabitModelAdapter extends TypeAdapter<GoodHabitModel> {
  @override
  final int typeId = 0;

  @override
  GoodHabitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoodHabitModel(
      id: fields[0] as String,
      title: fields[1] as String,
      startDate: fields[2] as DateTime,
      cues: (fields[3] as List?)?.cast<String>(),
      duration: fields[4] as int?,
      difficultyLevel: fields[5] as String?,
      selectedScheduleType: fields[6] as String,
      habitDays: (fields[7] as List?)?.cast<String>(),
      flexDays: fields[8] as int?,
      flexPerTime: fields[9] as String?,
      repDays: fields[10] as int?,
      timesDay: fields[11] as int?,
      isActive: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GoodHabitModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.cues)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.difficultyLevel)
      ..writeByte(6)
      ..write(obj.selectedScheduleType)
      ..writeByte(7)
      ..write(obj.habitDays)
      ..writeByte(8)
      ..write(obj.flexDays)
      ..writeByte(9)
      ..write(obj.flexPerTime)
      ..writeByte(10)
      ..write(obj.repDays)
      ..writeByte(11)
      ..write(obj.timesDay)
      ..writeByte(12)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoodHabitModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
