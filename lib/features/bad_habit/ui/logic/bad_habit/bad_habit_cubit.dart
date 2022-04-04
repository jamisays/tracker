import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';
import 'package:tracker/features/bad_habit/domain/usecases/add_bad_habit.dart';
import 'package:tracker/features/bad_habit/domain/usecases/bad_habit_relapsed.dart';
import 'package:tracker/features/bad_habit/domain/usecases/delete_bad_habit.dart';
import 'package:tracker/features/bad_habit/domain/usecases/get_bad_habits.dart';
import 'package:tracker/features/bad_habit/domain/usecases/update_bad_habits.dart';

part 'bad_habit_state.dart';

class BadHabitCubit extends Cubit<BadHabitState> {
  final GetBadHabits getBadHabits;
  final AddBadHabit addBadHabit;
  final UpdateBadHabit updateBadHabit;
  final DeleteBadHabit deleteBadHabit;
  final BadHabitRelapsed badHabitRelapsed;

  List<BadHabitModel> badHabitsList = [];

  BadHabitCubit({
    required this.getBadHabits,
    required this.addBadHabit,
    required this.updateBadHabit,
    required this.deleteBadHabit,
    required this.badHabitRelapsed,
  }) : super(BadHabitInitial());

  void cGetBadHabits() async {
    emit(LoadingBadHabits());
    badHabitsList = await getBadHabits();
    badHabitsList.isEmpty
        ? emit(Empty())
        : emit(LoadedBadHabits(badHabitsList: badHabitsList));
  }

  void cAddBadHabit(BadHabitModel newHabit) async {
    emit(LoadingBadHabits());
    addBadHabit(newHabit);
    badHabitsList.add(newHabit);
    emit(LoadedBadHabits(badHabitsList: badHabitsList));
  }

  void cUpdateBadHabit(BadHabitModel toBeUpdatedHabit) async {
    emit(LoadingBadHabits());
    updateBadHabit(toBeUpdatedHabit.id, toBeUpdatedHabit);
    final index = badHabitsList
        .indexWhere((element) => element.id == toBeUpdatedHabit.id);
    badHabitsList[index] = toBeUpdatedHabit;
    emit(LoadedBadHabits(badHabitsList: badHabitsList));
  }

  void cDeleteBadHabit(String id) async {
    emit(LoadingBadHabits());
    deleteBadHabit(id);
    badHabitsList.removeWhere((element) => element.id == id);
    badHabitsList.isEmpty
        ? emit(Empty())
        : emit(LoadedBadHabits(badHabitsList: badHabitsList));
  }

  void cBadHabitRelapsed(String key, DateTime time, String? reason) {
    emit(LoadingBadHabits());
    badHabitRelapsed(key, time, reason);
    // ui state
    final index = badHabitsList.indexWhere((element) => element.id == key);
    var item = badHabitsList[index];
    item.relapsedDaysList!.add(time);
    item.relapsedReasons![time] = reason!;
    item.lastDate = time;
    badHabitsList[index] = item;
    emit(LoadedBadHabits(badHabitsList: badHabitsList));
  }
}
