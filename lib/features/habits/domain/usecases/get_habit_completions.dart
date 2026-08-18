import 'package:injectable/injectable.dart';

import '../entities/habit_completion.dart';
import '../repositories/habit_completion_repository.dart';

@injectable
class GetHabitCompletions {
  final HabitCompletionRepository repository;

  GetHabitCompletions(this.repository);

  Future<List<HabitCompletion>> call(String habitId, String ownerId) {
    return repository.getCompletions(habitId, ownerId);
  }
}
