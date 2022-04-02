import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';

abstract class BadHabitRepository {
  Future<void> addBadHabit(BadHabitModel badhabit);
  Future<List<BadHabitModel>> getBadHabits();
  void updateBadHabit(String key, BadHabitModel badhabit);
  Future<void> deleteBadHabit(String key);
}
