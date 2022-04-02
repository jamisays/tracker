import 'package:tracker/features/bad_habit/domain/repositories/repository.dart';

class DeleteBadHabit {
  final BadHabitRepository repository;

  DeleteBadHabit(this.repository);

  Future<void> call(String key) async {
    await repository.deleteBadHabit(key);
  }
}
