import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_level/features/habits/domain/entities/habit_completion.dart';
import 'package:habit_level/features/habits/presentation/bloc/habit_completion/habit_completion_bloc.dart';

import '../../domain/entities/habit.dart';
import '../../../../app/theme/app_spacing.dart';
import 'habit_card.dart';

class HabitList extends StatelessWidget {
  final List<Habit> habits;
  final String ownerId;
  final List<HabitCompletion> completions;
  final VoidCallback onCreateHabit;
  final bool completionsLoaded;

  const HabitList({
    super.key,
    required this.habits,
    required this.ownerId,
    required this.completions,
    required this.onCreateHabit,
    required this.completionsLoaded,
  });

  @override
  Widget build(BuildContext context) {
    if (habits.isEmpty) {
      return _EmptyHabitsState(onCreateHabit: onCreateHabit);
    }

    final completedHabitIds = completions
        .map((completion) => completion.habitId)
        .toSet();

    return Column(
      children: [
        for (final habit in habits)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: HabitCard(
              key: ValueKey(habit.id),
              habit: habit,
              isCompleted: completedHabitIds.contains(habit.id),
              completionsLoaded: completionsLoaded,
              onComplete: () {
                context.read<HabitCompletionBloc>().add(
                  HabitCompletionCreateRequested(
                    habit: habit,
                    ownerId: ownerId,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _EmptyHabitsState extends StatelessWidget {
  final VoidCallback onCreateHabit;

  const _EmptyHabitsState({required this.onCreateHabit});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
        child: Column(
          children: [
            Icon(
              Icons.track_changes_outlined,
              size: 40,
              color: colorScheme.primary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Empieza con un hábito', style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Elige una práctica pequeña y registra tu constancia.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: onCreateHabit,
              icon: const Icon(Icons.add),
              label: const Text('Crear primer hábito'),
            ),
          ],
        ),
      ),
    );
  }
}
