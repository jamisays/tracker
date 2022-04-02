import 'package:tracker/features/bad_habit/data/models/bad_habit_model.dart';
import 'package:tracker/features/bad_habit/domain/repositories/repository.dart';

class AddBadHabit {
  final BadHabitRepository repository;

  AddBadHabit(this.repository);

  Future<void> call(BadHabitModel badHabit) async {
    return await repository.addBadHabit(badHabit);
  }
}
