import 'package:hive/hive.dart';

abstract class BadHabitRelapsedDataService {
  badHabitRelapsed(String key, DateTime time, String? reason);
}

class BadHabitRelapsedDataServiceImpl implements BadHabitRelapsedDataService {
  @override
  badHabitRelapsed(String key, DateTime time, String? reason) async {
    final box = await Hive.openBox('bad_habit_box');
    var item = box.get(key);

    item.relapsedDaysList.add(time);
    item.relapsedReasons[time] = reason;
    item.lastDate = time;

    box.put(key, item);
    await box.close();
  }
}
