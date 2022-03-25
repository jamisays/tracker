import 'package:hive/hive.dart';
import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';

abstract class UpdateGoodHabitDataService {
  void updateHabitToDataBase(String key, GoodHabitModel goodHabit);
}

class UpdateGoodHabitDataServiceImpl implements UpdateGoodHabitDataService {
  @override
  void updateHabitToDataBase(String key, GoodHabitModel goodHabit) async {
    try {
      final box = await Hive.openBox('good_habit_box');
      await box.put(key, goodHabit);
      await box.close();
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
