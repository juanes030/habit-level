import 'package:injectable/injectable.dart';

import '../../domain/entities/habit.dart';
import '../../domain/repositories/habit_repository.dart';
import '../datasources/habit_remote_data_source.dart';
import '../models/habit_model.dart';

@LazySingleton(as: HabitRepository)
class HabitRepositoryImpl implements HabitRepository {
  final HabitRemoteDataSource remoteDataSource;

  HabitRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Habit>> getHabits(String ownerId) {
    return remoteDataSource.getHabits(ownerId);
  }

  @override
  Future<Habit> getHabit(String habitId) {
    return remoteDataSource.getHabit(habitId);
  }

  @override
  Future<Habit> createHabit(Habit habit) {
    final model = HabitModel.fromEntity(habit);

    return remoteDataSource.createHabit(model);
  }

  @override
  Future<Habit> updateHabit(Habit habit) {
    final model = HabitModel.fromEntity(habit);

    return remoteDataSource.updateHabit(model);
  }

  @override
  Future<void> deleteHabit(String habitId) {
    return remoteDataSource.deleteHabit(habitId);
  }
}
