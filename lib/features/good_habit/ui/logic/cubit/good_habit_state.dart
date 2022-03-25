part of 'good_habit_cubit.dart';

abstract class GoodHabitState extends Equatable {
  const GoodHabitState();

  @override
  List<Object?> get props => [];
}

class GoodHabitInitial extends GoodHabitState {}

// load Good habits from database
class Empty extends GoodHabitState {
  @override
  List<Object?> get props => [];
}

class LoadingGoodHabits extends GoodHabitState {
  @override
  List<Object?> get props => [];
}

class LoadedGoodHabits extends GoodHabitState {
  final List<GoodHabitModel> goodHabitsList;

  const LoadedGoodHabits({required this.goodHabitsList});

  @override
  List<Object?> get props => [goodHabitsList];
}

// add habit
class AddError extends GoodHabitState {
  @override
  List<Object?> get props => [];
}

// update habit
class UpdateError extends GoodHabitState {
  @override
  List<Object?> get props => [];
}

// delete habit
class DeleteError extends GoodHabitState {
  @override
  List<Object?> get props => [];
}
