import 'package:injectable/injectable.dart';

import '../../domain/entities/habit_completion.dart';
import '../../domain/repositories/habit_completion_repository.dart';
import '../datasources/habit_completion_remote_data_source.dart';
import '../models/habit_completion_model.dart';

@LazySingleton(as: HabitCompletionRepository)
class HabitCompletionRepositoryImpl implements HabitCompletionRepository {
  final HabitCompletionRemoteDataSource remoteDataSource;

  HabitCompletionRepositoryImpl(this.remoteDataSource);

  @override
  Future<HabitCompletion> createCompletion(HabitCompletion completion) async {
    final model = HabitCompletionModel(
      id: completion.id,
      habitId: completion.habitId,
      ownerId: completion.ownerId,
      date: completion.date,
      completedAt: completion.completedAt,
      value: completion.value,
    );

    return remoteDataSource.createCompletion(model);
  }

  @override
  Future<List<HabitCompletion>> getCompletions(String habitId, String ownerId) {
    return remoteDataSource.getCompletions(habitId, ownerId);
  }
}
