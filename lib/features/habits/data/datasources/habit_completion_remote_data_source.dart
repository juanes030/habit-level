import '../models/habit_completion_model.dart';

abstract class HabitCompletionRemoteDataSource {
  Future<HabitCompletionModel> createCompletion(
    HabitCompletionModel completion,
  );

  Future<List<HabitCompletionModel>> getCompletions(
    String habitId,
    String ownerId,
  );
}
