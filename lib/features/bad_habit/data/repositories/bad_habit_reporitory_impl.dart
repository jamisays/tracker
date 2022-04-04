import 'package:tracker/features/bad_habit/data/data_service/add_bad_habit_data_service.dart';
import 'package:tracker/features/bad_habit/data/data_service/bad_habit_relapsed_data_service.dart';
import 'package:tracker/features/bad_habit/data/data_service/delete_bad_habit_data_service.dart';
import 'package:tracker/features/bad_habit/data/data_service/get_bad_habits_data_service.dart';
import 'package:tracker/features/bad_habit/data/data_service/update_bad_habit_data_source.dart';
import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';
import 'package:tracker/features/bad_habit/domain/repositories/repository.dart';

class BadHabitRepositoryImpl implements BadHabitRepository {
  final AddBadHabitDataService addHabitDataService;
  final GetBadHabitsDataService getBadHabitsDataService;
  final UpdateBadHabitDataService updateHabitDataService;
  final DeleteBadHabitDataService deleteHabitDataService;
  final BadHabitRelapsedDataService badHabitRelapsedDataService;

  BadHabitRepositoryImpl({
    required this.addHabitDataService,
    required this.getBadHabitsDataService,
    required this.updateHabitDataService,
    required this.deleteHabitDataService,
    required this.badHabitRelapsedDataService,
  });

  @override
  Future<void> addBadHabit(BadHabitModel goodHabit) async {
    try {
      addHabitDataService.addHabitToDataBase(goodHabit);
    } catch (error) {
      throw Error();
    }
  }

  @override
  Future<List<BadHabitModel>> getBadHabits() async {
    try {
      final habits = getBadHabitsDataService.getBadHabits();
      return habits;
    } catch (error) {
      throw Error();
    }
  }

  @override
  void updateBadHabit(String key, BadHabitModel goodhabit) {
    try {
      updateHabitDataService.updateHabitToDataBase(key, goodhabit);
    } catch (error) {
      throw Error();
    }
  }

  @override
  Future<void> deleteBadHabit(String key) async {
    try {
      deleteHabitDataService.deleteBadHabitFromDataBase(key);
    } catch (error) {
      throw Error();
    }
  }

  @override
  void badHabitRelapsed(String key, DateTime time, String? reason) {
    try {
      badHabitRelapsedDataService.badHabitRelapsed(key, time, reason);
    } catch (error) {
      throw Error();
    }
  }
}
