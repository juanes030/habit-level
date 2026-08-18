import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_level/features/habits/domain/entities/habit_completion.dart';
import 'package:habit_level/features/habits/presentation/bloc/habit_completion/habit_completion_bloc.dart';

import '../../domain/entities/habit.dart';

class HabitList extends StatelessWidget {
  final List<Habit> habits;
  final String ownerId;

  const HabitList({super.key, required this.habits, required this.ownerId});

  @override
  Widget build(BuildContext context) {
    if (habits.isEmpty) {
      return const Center(child: Text('No tienes hábitos todavía.'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final habit = habits[index];

      return ListTile(
      title: Text(habit.title),
          subtitle: Text(habit.description),
          trailing: IconButton(
            icon: const Icon(Icons.check_circle_outline),
            onPressed: () {
              final now = DateTime.now();

              final completion = HabitCompletion(
                id: '',
                habitId: habit.id,
                ownerId: ownerId,
                date: DateTime(now.year, now.month, now.day),
                completedAt: now,
                value: habit.target,
              );

              context.read<HabitCompletionBloc>().add(
                HabitCompletionCreateRequested(completion),
              );
            },
          ),
        );
      },
    );
  }
}
