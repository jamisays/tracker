import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class BadHabit extends Equatable {
  final String id;
  final String? category;
  final String title;
  final DateTime createDate;
  final List<String>? reasons;
  final int? duration;
  final String difficultyLevel;
  final bool isActive;
  final bool? isCustom;
  final String timesType;
  final int? timesDay;
  final int? costPerTime;
  final List<DateTime>? relapsedDaysList;
  final Map<DateTime, String>? relapsedReasons;
  DateTime? lastDate;

  BadHabit({
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
}
