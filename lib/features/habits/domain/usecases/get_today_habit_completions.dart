import 'package:injectable/injectable.dart';

import '../entities/habit_completion.dart';
import '../repositories/habit_completion_repository.dart';

@injectable
class GetTodayHabitCompletions {
  final HabitCompletionRepository repository;

  GetTodayHabitCompletions(this.repository);

  Future<List<HabitCompletion>> call(String ownerId) {
    return repository.getTodayCompletions(ownerId);
  }
}
