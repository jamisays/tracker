import 'package:hive/hive.dart';

abstract class DeleteGoodHabitDataService {
  void deleteGoodHabitFromDataBase(String key);
}

class DeleteGoodHabitDataServiceImpl implements DeleteGoodHabitDataService {
  @override
  void deleteGoodHabitFromDataBase(String key) async {
    try {
      final box = await Hive.openBox('good_habit_box');
      await box.delete(key);
      await box.close();
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
