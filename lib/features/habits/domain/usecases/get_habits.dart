import 'package:injectable/injectable.dart';

import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

@injectable
class GetHabits {
  final HabitRepository repository;

  GetHabits(this.repository);

  Future<List<Habit>> call(String ownerId) {
    return repository.getHabits(ownerId);
  }
}
