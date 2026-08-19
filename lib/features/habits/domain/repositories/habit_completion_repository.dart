import '../entities/habit_completion.dart';

abstract class HabitCompletionRepository {
  Future<HabitCompletion> createCompletion(HabitCompletion completion);

  Future<List<HabitCompletion>> getCompletions(String habitId, String ownerId);

  Future<HabitCompletion?> getCompletionForDate(
    String habitId,
    String ownerId,
    DateTime date,
  );

  Future<List<HabitCompletion>> getTodayCompletions(String ownerId);
}
