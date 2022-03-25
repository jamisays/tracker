import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tracker/features/good_habit/domain/usecases/add_good_habit.dart';
import 'package:tracker/features/good_habit/domain/usecases/delete_good_habit.dart';
import 'package:tracker/features/good_habit/domain/usecases/get_good_habits.dart';
import 'package:tracker/features/good_habit/domain/usecases/update_good_habit.dart';
import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';

part 'good_habit_state.dart';

class GoodHabitCubit extends Cubit<GoodHabitState> {
  final GetGoodHabits getGoodHabits;
  final AddGoodHabit addGoodHabit;
  final UpdateGoodHabit updateGoodHabit;
  final DeleteGoodHabit deleteGoodHabit;

  List<GoodHabitModel> goodHabitsList = [];

  GoodHabitCubit({
    required this.getGoodHabits,
    required this.addGoodHabit,
    required this.updateGoodHabit,
    required this.deleteGoodHabit,
  }) : super(GoodHabitInitial());

  void cGetGoodHabits() async {
    emit(LoadingGoodHabits());
    goodHabitsList = await getGoodHabits();
    goodHabitsList.isEmpty
        ? emit(Empty())
        : emit(LoadedGoodHabits(goodHabitsList: goodHabitsList));
  }

  void cAddGoodHabit(GoodHabitModel newHabit) async {
    emit(LoadingGoodHabits());
    addGoodHabit(newHabit);
    goodHabitsList.add(newHabit);
    emit(LoadedGoodHabits(goodHabitsList: goodHabitsList));
  }

  void cUpdateGoodHabit(GoodHabitModel toBeUpdatedHabit) async {
    emit(LoadingGoodHabits());
    updateGoodHabit(toBeUpdatedHabit.id, toBeUpdatedHabit);
    final index = goodHabitsList
        .indexWhere((element) => element.id == toBeUpdatedHabit.id);
    goodHabitsList[index] = toBeUpdatedHabit;
    emit(LoadedGoodHabits(goodHabitsList: goodHabitsList));
  }

  void cDeleteGoodHabit(String id) async {
    emit(LoadingGoodHabits());
    deleteGoodHabit(id);
    goodHabitsList.removeWhere((element) => element.id == id);
    goodHabitsList.isEmpty
        ? emit(Empty())
        : emit(LoadedGoodHabits(goodHabitsList: goodHabitsList));
  }
}
