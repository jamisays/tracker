import 'package:tracker/features/bad_habit/domain/repositories/repository.dart';

class BadHabitRelapsed {
  final BadHabitRepository repository;

  BadHabitRelapsed(this.repository);

  void call(String key, DateTime time, String? reason) async {
    repository.badHabitRelapsed(key, time, reason);
  }
}
