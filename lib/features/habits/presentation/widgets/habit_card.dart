import 'package:flutter/material.dart';
import 'package:habit_level/app/theme/app_colors.dart';
import 'package:habit_level/app/theme/app_spacing.dart';
import 'package:habit_level/features/habits/domain/entities/habit.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final bool isCompleted;
  final bool completionsLoaded;
  final VoidCallback onComplete;

  const HabitCard({
    super.key,
    required this.habit,
    required this.isCompleted,
    required this.completionsLoaded,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final successColor = Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkSuccess
        : AppColors.success;

    return Card(
      margin: EdgeInsets.zero,
      color: colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(habit.title, style: textTheme.titleLarge),
                  if (habit.description.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      habit.description,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      _HabitDetail(
                        icon: Icons.repeat,
                        label: habit.frequency == 'weekly'
                            ? 'Semanal'
                            : 'Diario',
                      ),
                      _HabitDetail(
                        icon: Icons.flag_outlined,
                        label: '${habit.target} ${_unitLabel(habit.unit)}',
                      ),
                      if (isCompleted)
                        _HabitDetail(
                          icon: Icons.check,
                          label: 'Completado hoy',
                          color: successColor,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              tooltip: isCompleted
                  ? '${habit.title}: completado hoy'
                  : completionsLoaded
                  ? 'Marcar ${habit.title} como completado'
                  : 'Cargando el progreso de hoy',
              onPressed: isCompleted || !completionsLoaded ? null : onComplete,
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  isCompleted ? Icons.check : Icons.check_outlined,
                  key: ValueKey(isCompleted),
                ),
              ),
              style: IconButton.styleFrom(
                fixedSize: const Size(48, 48),
                shape: const CircleBorder(),
                backgroundColor: isCompleted
                    ? successColor
                    : colorScheme.primaryContainer,
                foregroundColor: isCompleted
                    ? colorScheme.surface
                    : colorScheme.onPrimaryContainer,
                disabledBackgroundColor: isCompleted
                    ? successColor
                    : colorScheme.surfaceContainerHighest,
                disabledForegroundColor: isCompleted
                    ? colorScheme.surface
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _unitLabel(String unit) {
    return switch (unit) {
      'minutes' => 'min',
      'kilometers' => 'km',
      'glasses' => 'vasos',
      'repetitions' => 'reps',
      _ => unit,
    };
  }
}

class _HabitDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _HabitDetail({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.control / 2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color ?? colorScheme.onSurfaceVariant),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(color: color ?? colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
