import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';
import 'package:tracker/features/good_habit/domain/repositories/good_habit_repository.dart';

class UpdateGoodHabit {
  final GoodHabitRepository repository;

  UpdateGoodHabit(this.repository);

  void call(String key, GoodHabitModel goodHabit) {
    repository.updateGoodHabit(key, goodHabit);
  }
}
