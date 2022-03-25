import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';

abstract class GoodHabitRepository {
  Future<void> addGoodHabit(GoodHabitModel goodhabit);
  Future<List<GoodHabitModel>> getGoodHabits();
  void updateGoodHabit(String key, GoodHabitModel goodhabit);
  Future<void> deleteGoodHabit(String key);
}
