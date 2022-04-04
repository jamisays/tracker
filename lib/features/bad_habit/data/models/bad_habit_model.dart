import 'package:hive/hive.dart';

import 'package:tracker/features/bad_habit/domain/entities/bad_habit.dart';

part 'bad_habit_model.g.dart';

@HiveType(typeId: 1)
// ignore: must_be_immutable
class BadHabitModel implements BadHabit {
  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String? category;
  @override
  @HiveField(2)
  final String title;
  @override
  @HiveField(3)
  final DateTime createDate;
  @override
  @HiveField(4)
  final List<String>? reasons;
  @override
  @HiveField(5)
  final int? duration;
  @override
  @HiveField(6)
  final String difficultyLevel;
  @override
  @HiveField(7)
  final bool isActive;
  @override
  @HiveField(8)
  final bool? isCustom;
  @override
  @HiveField(9)
  final String timesType;
  @override
  @HiveField(10)
  final int? timesDay;
  @override
  @HiveField(11)
  final int? costPerTime;
  @override
  @HiveField(12)
  final List<DateTime>? relapsedDaysList;
  @override
  @HiveField(13)
  final Map<DateTime, String>? relapsedReasons;
  @override
  @HiveField(14)
  DateTime? lastDate;

  BadHabitModel({
    required this.id,
    this.category,
    required this.title,
    required this.createDate,
    this.reasons,
    this.duration,
    required this.difficultyLevel,
    required this.isActive,
    this.isCustom,
    required this.timesType,
    required this.timesDay,
    required this.costPerTime,
    this.relapsedDaysList,
    this.relapsedReasons,
    this.lastDate,
  });

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool? get stringify => throw UnimplementedError();
}
