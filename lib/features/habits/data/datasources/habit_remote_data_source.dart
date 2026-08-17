import 'package:habit_level/features/habits/domain/entities/habit.dart';

abstract class HabitRemoteDataSource {
  Future<List<Habit>> getHabits(String ownerId);

  Future<Habit> getHabit(String habitId);

  Future<Habit> createHabit(Habit habit);

  Future<Habit> updateHabit(Habit habit);

  Future<void> deleteHabit(String habitId);
}
