import 'package:tracker/features/good_habit/domain/repositories/good_habit_repository.dart';

class DeleteGoodHabit {
  final GoodHabitRepository repository;

  DeleteGoodHabit(this.repository);

  Future<void> call(String key) async {
    await repository.deleteGoodHabit(key);
  }
}
