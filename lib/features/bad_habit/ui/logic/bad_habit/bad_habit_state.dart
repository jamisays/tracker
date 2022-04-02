part of 'bad_habit_cubit.dart';

abstract class BadHabitState extends Equatable {
  const BadHabitState();

  @override
  List<Object?> get props => [];
}

class BadHabitInitial extends BadHabitState {}

// load Bad habits from database
class Empty extends BadHabitState {}

class LoadingBadHabits extends BadHabitState {}

class LoadedBadHabits extends BadHabitState {
  final List<BadHabitModel> badHabitsList;

  const LoadedBadHabits({required this.badHabitsList});

  @override
  List<Object?> get props => [badHabitsList];
}

// add habit
class AddError extends BadHabitState {}

// update habit
class UpdateError extends BadHabitState {}

// delete habit
class DeleteError extends BadHabitState {}
