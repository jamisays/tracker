import 'package:hive/hive.dart';

import 'package:tracker/features/good_habit/domain/entities/good_habit.dart';

part 'good_habit_model.g.dart';

@HiveType(typeId: 0)
class GoodHabitModel implements GoodHabit {
  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String title;
  @override
  @HiveField(2)
  final DateTime startDate;
  @override
  @HiveField(3)
  final List<String>? cues;
  @override
  @HiveField(4)
  final int? duration;
  @override
  @HiveField(5)
  final String? difficultyLevel;
  @override
  @HiveField(6)
  final String selectedScheduleType;
  @override
  @HiveField(7)
  final List<String>? habitDays;
  @override
  @HiveField(8)
  final int? flexDays;
  @override
  @HiveField(9)
  final String? flexPerTime;
  @override
  @HiveField(10)
  final int? repDays;
  @override
  @HiveField(11)
  final int? timesDay;
  @override
  @HiveField(12)
  final bool isActive;

  GoodHabitModel({
    required this.id,
    required this.title,
    required this.startDate,
    this.cues,
    this.duration,
    this.difficultyLevel,
    required this.selectedScheduleType,
    this.habitDays,
    this.flexDays,
    this.flexPerTime,
    this.repDays,
    required this.timesDay,
    required this.isActive,
  });

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool? get stringify => throw UnimplementedError();
}
