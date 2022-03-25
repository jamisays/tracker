import 'package:tracker/features/good_habit/data/models/good_habit_model.dart';
import 'package:tracker/features/good_habit/domain/repositories/good_habit_repository.dart';

class GetGoodHabits {
  final GoodHabitRepository repository;

  GetGoodHabits(this.repository);

  Future<List<GoodHabitModel>> call() async {
    return repository.getGoodHabits();
  }
}
