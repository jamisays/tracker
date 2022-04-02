import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';
import 'package:tracker/features/bad_habit/domain/repositories/repository.dart';

class UpdateBadHabit {
  final BadHabitRepository repository;

  UpdateBadHabit(this.repository);

  void call(String key, BadHabitModel goodHabit) {
    repository.updateBadHabit(key, goodHabit);
  }
}
