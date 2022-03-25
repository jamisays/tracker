import 'package:hive/hive.dart';
import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';

abstract class GetGoodHabitsDataService {
  Future<List<GoodHabitModel>> getGoodHabits();
}

class GetGoodHabitsDataServiceImpl implements GetGoodHabitsDataService {
  @override
  Future<List<GoodHabitModel>> getGoodHabits() async {
    try {
      final box = await Hive.openBox<GoodHabitModel>('good_habit_box');
      final result = box.values.toList();
      box.close();
      return result;
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
