import '../entities/habit_completion.dart';

abstract class HabitCompletionRepository {
  Future<HabitCompletion> createCompletion(HabitCompletion completion);

  Future<List<HabitCompletion>> getCompletions(String habitId, String ownerId);
}
