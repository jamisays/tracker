import 'package:hive/hive.dart';
import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';

abstract class GetBadHabitsDataService {
  Future<List<BadHabitModel>> getBadHabits();
}

class GetBadHabitsDataServiceImpl implements GetBadHabitsDataService {
  @override
  Future<List<BadHabitModel>> getBadHabits() async {
    try {
      final box = await Hive.openBox<BadHabitModel>('bad_habit_box');
      final result = box.values.toList();
      box.close();
      return result;
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
