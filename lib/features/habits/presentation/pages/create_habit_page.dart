import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_level/app/theme/app_spacing.dart';
import 'package:habit_level/core/di/injection.dart';
import 'package:habit_level/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:habit_level/features/habits/presentation/bloc/habit/habit_bloc.dart';
import 'package:habit_level/features/habits/presentation/widgets/habit_form.dart';

import '../../domain/entities/habit.dart';

class CreateHabitPage extends StatelessWidget {
  const CreateHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;

    if (authState is! AuthAuthenticated) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return BlocProvider(
      create: (_) => getIt<HabitBloc>(),
      child: _CreateHabitView(ownerId: authState.user.id),
    );
  }
}

class _CreateHabitView extends StatelessWidget {
  final String ownerId;

  const _CreateHabitView({required this.ownerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear hábito')),
      body: BlocListener<HabitBloc, HabitState>(
        listener: (context, state) {
          if (state is HabitLoaded) {
            context.pop(true);
          }
        },
        child: BlocBuilder<HabitBloc, HabitState>(
          builder: (context, state) => ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text(
                'Una práctica pequeña puede convertirse en progreso real.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (state is HabitError) ...[
                const SizedBox(height: AppSpacing.md),
                _CreateHabitError(message: state.message),
              ],
              const SizedBox(height: AppSpacing.lg),
              HabitForm(
                isSubmitting: state is HabitLoading,
                onSubmit: (formData) {
                  final now = DateTime.now();
                  final habit = Habit(
                    id: '',
                    ownerId: ownerId,
                    title: formData.title,
                    description: formData.description,
                    frequency: formData.frequency,
                    target: formData.target,
                    unit: formData.unit,
                    isActive: true,
                    createdAt: now,
                    updatedAt: now,
                  );
                  context.read<HabitBloc>().add(HabitCreateRequested(habit));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateHabitError extends StatelessWidget {
  final String message;

  const _CreateHabitError({required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(AppRadius.control),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: colorScheme.onErrorContainer),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: colorScheme.onErrorContainer),
            ),
          ),
        ],
      ),
    );
  }
}
