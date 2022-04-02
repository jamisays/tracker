import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';
import 'package:tracker/features/bad_habit/domain/repositories/repository.dart';

class GetBadHabits {
  final BadHabitRepository repository;

  GetBadHabits(this.repository);

  Future<List<BadHabitModel>> call() async {
    return repository.getBadHabits();
  }
}
