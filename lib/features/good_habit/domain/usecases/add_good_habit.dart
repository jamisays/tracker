import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';
import 'package:tracker/features/good_habit/domain/repositories/good_habit_repository.dart';

class AddGoodHabit {
  final GoodHabitRepository repository;

  AddGoodHabit(this.repository);

  Future<void> call(GoodHabitModel goodHabit) async {
    return await repository.addGoodHabit(goodHabit);
  }
}
