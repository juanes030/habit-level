import 'package:habit_level/features/habits/domain/exceptions/habit_completion_exceptions.dart';
import 'package:injectable/injectable.dart';

import '../entities/habit.dart';
import '../entities/habit_completion.dart';
import '../repositories/habit_completion_repository.dart';

@injectable
class CreateHabitCompletion {
  final HabitCompletionRepository repository;

  CreateHabitCompletion(this.repository);

  Future<HabitCompletion> call(Habit habit, {required String ownerId}) async {
    final completedAt = DateTime.now();
    final completion = HabitCompletion(
      id: '',
      habitId: habit.id,
      ownerId: ownerId,
      date: DateTime(completedAt.year, completedAt.month, completedAt.day),
      completedAt: completedAt,
      value: habit.target,
    );

    if (habit.frequency == 'daily') {
      final existingCompletion = await repository.getCompletionForDate(
        completion.habitId,
        completion.ownerId,
        completion.date,
      );

      if (existingCompletion != null) {
        throw const HabitAlreadyCompletedException();
      }
    }

    return repository.createCompletion(completion);
  }
}
