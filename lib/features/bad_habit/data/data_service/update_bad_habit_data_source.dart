import 'package:hive/hive.dart';
import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';

abstract class UpdateBadHabitDataService {
  void updateHabitToDataBase(String key, BadHabitModel badHabit);
}

class UpdateBadHabitDataServiceImpl implements UpdateBadHabitDataService {
  @override
  void updateHabitToDataBase(String key, BadHabitModel badHabit) async {
    try {
      final box = await Hive.openBox('bad_habit_box');
      await box.put(key, badHabit);
      await box.close();
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
