import 'package:hive/hive.dart';

abstract class DeleteBadHabitDataService {
  void deleteBadHabitFromDataBase(String key);
}

class DeleteBadHabitDataServiceImpl implements DeleteBadHabitDataService {
  @override
  void deleteBadHabitFromDataBase(String key) async {
    try {
      final box = await Hive.openBox('bad_habit_box');
      await box.delete(key);
      await box.close();
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
