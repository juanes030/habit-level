import 'package:injectable/injectable.dart';

import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

@injectable
class CreateHabit {
  final HabitRepository repository;

  CreateHabit(this.repository);

  Future<Habit> call(Habit habit) {
    return repository.createHabit(habit);
  }
}