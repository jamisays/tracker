import 'package:tracker/features/good_habit/data/data_service/add_good_habit_data_service.dart';
import 'package:tracker/features/good_habit/data/data_service/delete_good_habit_data_service.dart';
import 'package:tracker/features/good_habit/data/data_service/get_good_habits_data_service.dart';
import 'package:tracker/features/good_habit/data/data_service/update_good_habit_data_source.dart';
import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';
import 'package:tracker/features/good_habit/domain/repositories/good_habit_repository.dart';

class GoodHabitRepositoryImpl implements GoodHabitRepository {
  final AddGoodHabitDataService addHabitDataService;
  final GetGoodHabitsDataService getGoodHabitsDataService;
  final UpdateGoodHabitDataService updateHabitDataService;
  final DeleteGoodHabitDataService deleteHabitDataService;

  GoodHabitRepositoryImpl({
    required this.addHabitDataService,
    required this.getGoodHabitsDataService,
    required this.updateHabitDataService,
    required this.deleteHabitDataService,
  });

  @override
  Future<void> addGoodHabit(GoodHabitModel goodHabit) async {
    try {
      addHabitDataService.addHabitToDataBase(goodHabit);
    } catch (error) {
      throw Error();
    }
  }

  @override
  Future<List<GoodHabitModel>> getGoodHabits() async {
    try {
      final habits = getGoodHabitsDataService.getGoodHabits();
      return habits;
    } catch (error) {
      throw Error();
    }
  }

  @override
  void updateGoodHabit(String key, GoodHabitModel goodhabit) {
    try {
      updateHabitDataService.updateHabitToDataBase(key, goodhabit);
    } catch (error) {
      throw Error();
    }
  }

  @override
  Future<void> deleteGoodHabit(String key) async {
    try {
      deleteHabitDataService.deleteGoodHabitFromDataBase(key);
    } catch (error) {
      throw Error();
    }
  }
}
