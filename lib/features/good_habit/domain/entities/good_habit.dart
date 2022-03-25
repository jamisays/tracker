import 'package:equatable/equatable.dart';

class GoodHabit extends Equatable {
  final String id;
  final String title;
  final DateTime startDate;
  final List<String>? cues;
  final int? duration;
  final String? difficultyLevel;
  final String selectedScheduleType;
  final List<String>? habitDays;
  final int? flexDays;
  final String? flexPerTime;
  final int? repDays;
  final int? timesDay;
  final bool isActive;

  const GoodHabit({
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
}
