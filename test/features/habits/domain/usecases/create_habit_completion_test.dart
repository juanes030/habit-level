import 'package:flutter_test/flutter_test.dart';
import 'package:habit_level/features/habits/domain/entities/habit.dart';
import 'package:habit_level/features/habits/domain/entities/habit_completion.dart';
import 'package:habit_level/features/habits/domain/exceptions/habit_completion_exceptions.dart';
import 'package:habit_level/features/habits/domain/repositories/habit_completion_repository.dart';
import 'package:habit_level/features/habits/domain/usecases/create_habit_completion.dart';

void main() {
  test(
    'creates a daily completion with the habit target and calendar date',
    () async {
      final repository = _FakeHabitCompletionRepository();
      final useCase = CreateHabitCompletion(repository);

      final completion = await useCase(_habit(), ownerId: 'owner-1');

      expect(completion.habitId, 'habit-1');
      expect(completion.ownerId, 'owner-1');
      expect(completion.value, 20);
      expect(completion.date.hour, 0);
      expect(completion.date.minute, 0);
      expect(repository.lookedUpDate, completion.date);
      expect(repository.createdCompletion, completion);
    },
  );

  test('rejects a second daily completion', () async {
    final repository = _FakeHabitCompletionRepository()
      ..existingCompletion = _completion();
    final useCase = CreateHabitCompletion(repository);

    await expectLater(
      useCase(_habit(), ownerId: 'owner-1'),
      throwsA(isA<HabitAlreadyCompletedException>()),
    );

    expect(repository.createdCompletion, isNull);
  });

  test('does not apply the daily duplicate check to weekly habits', () async {
    final repository = _FakeHabitCompletionRepository();
    final useCase = CreateHabitCompletion(repository);

    await useCase(_habit(frequency: 'weekly'), ownerId: 'owner-1');

    expect(repository.lookupCount, 0);
    expect(repository.createdCompletion, isNotNull);
  });
}

Habit _habit({String frequency = 'daily'}) {
  return Habit(
    id: 'habit-1',
    ownerId: 'owner-1',
    title: 'Leer',
    description: 'Leer cada día',
    frequency: frequency,
    target: 20,
    unit: 'minutes',
    isActive: true,
    createdAt: DateTime(2025),
    updatedAt: DateTime(2025),
  );
}

HabitCompletion _completion() {
  final now = DateTime.now();
  return HabitCompletion(
    id: 'completion-1',
    habitId: 'habit-1',
    ownerId: 'owner-1',
    date: DateTime(now.year, now.month, now.day),
    completedAt: now,
    value: 20,
  );
}

class _FakeHabitCompletionRepository implements HabitCompletionRepository {
  HabitCompletion? createdCompletion;
  HabitCompletion? existingCompletion;
  DateTime? lookedUpDate;
  int lookupCount = 0;

  @override
  Future<HabitCompletion> createCompletion(HabitCompletion completion) async {
    createdCompletion = completion;
    return completion;
  }

  @override
  Future<List<HabitCompletion>> getCompletions(
    String habitId,
    String ownerId,
  ) async {
    return [];
  }

  @override
  Future<HabitCompletion?> getCompletionForDate(
    String habitId,
    String ownerId,
    DateTime date,
  ) async {
    lookupCount++;
    lookedUpDate = date;
    return existingCompletion;
  }

  @override
  Future<List<HabitCompletion>> getTodayCompletions(String ownerId) async {
    return [];
  }
}
