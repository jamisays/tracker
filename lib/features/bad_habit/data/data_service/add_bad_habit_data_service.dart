import 'package:hive/hive.dart';
import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';

abstract class AddBadHabitDataService {
  void addHabitToDataBase(BadHabitModel goodHabit);
}

class AddBadHabitDataServiceImpl implements AddBadHabitDataService {
  @override
  Future<void> addHabitToDataBase(BadHabitModel badHabit) async {
    try {
      final box = await Hive.openBox('bad_habit_box');
      await box.put(badHabit.id, badHabit);
      await box.close();
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
