import 'package:injectable/injectable.dart';

import '../entities/habit_completion.dart';
import '../repositories/habit_completion_repository.dart';

@injectable
class CreateHabitCompletion {
  final HabitCompletionRepository repository;

  CreateHabitCompletion(this.repository);

  Future<HabitCompletion> call(HabitCompletion completion) {
    return repository.createCompletion(completion);
  }
}
