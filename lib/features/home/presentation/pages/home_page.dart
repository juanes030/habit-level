import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_level/app/theme/app_spacing.dart';
import 'package:habit_level/core/di/injection.dart';
import 'package:habit_level/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:habit_level/features/habits/domain/entities/habit_completion.dart';
import 'package:habit_level/features/habits/presentation/bloc/habit/habit_bloc.dart';
import 'package:habit_level/features/habits/presentation/bloc/habit_completion/habit_completion_bloc.dart';
import 'package:habit_level/features/habits/presentation/widgets/habit_list.dart';
import 'package:habit_level/features/home/presentation/widgets/home_states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;

    if (authState is! AuthAuthenticated) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<HabitBloc>()..add(HabitLoadRequested(authState.user.id)),
        ),
        BlocProvider(
          create: (_) =>
              getIt<HabitCompletionBloc>()
                ..add(TodayHabitCompletionsLoadRequested(authState.user.id)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HabitLevel'),
          actions: [
            PopupMenuButton<String>(
              tooltip: 'Opciones',
              onSelected: (value) {
                if (value == 'logout') {
                  context.read<AuthBloc>().add(const AuthSignOutRequested());
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: AppSpacing.sm),
                      Text('Cerrar sesión'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<HabitBloc, HabitState>(
          builder: (context, state) {
            if (state is! HabitLoaded || state.habits.isEmpty) {
              return const SizedBox.shrink();
            }

            return FloatingActionButton.extended(
              onPressed: () => _openCreateHabit(context, authState.user.id),
              icon: const Icon(Icons.add),
              label: const Text('Crear hábito'),
            );
          },
        ),
        body: BlocListener<HabitCompletionBloc, HabitCompletionState>(
          listener: (context, completionState) {
            if (completionState is HabitCompletionCreated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Hábito completado')),
              );
            }

            if (completionState is HabitCompletionError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(completionState.message)));
            }
          },
          child: BlocBuilder<HabitBloc, HabitState>(
            builder: (context, habitState) {
              if (habitState is HabitLoading) {
                return const HomeLoadingState();
              }

              if (habitState is HabitError) {
                return HomeErrorState(
                  onRetry: () {
                    context.read<HabitBloc>().add(
                      HabitLoadRequested(authState.user.id),
                    );
                  },
                );
              }

              if (habitState is HabitLoaded) {
                return BlocBuilder<HabitCompletionBloc, HabitCompletionState>(
                  builder: (context, completionState) {
                    final completionsLoaded =
                        completionState is TodayHabitCompletionsLoaded;
                    final completions = completionsLoaded
                        ? completionState.completions
                        : <HabitCompletion>[];
                    final completedCount = habitState.habits
                        .where(
                          (habit) => completions.any(
                            (completion) => completion.habitId == habit.id,
                          ),
                        )
                        .length;

                    return ListView(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      children: [
                        Text(
                          'Hoy',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Cada día suma.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                        if (habitState.habits.isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.lg),
                          if (completionsLoaded)
                            HomeProgressSummary(
                              completedCount: completedCount,
                              totalCount: habitState.habits.length,
                            )
                          else if (completionState is HabitCompletionError)
                            TextButton.icon(
                              onPressed: () {
                                context.read<HabitCompletionBloc>().add(
                                  TodayHabitCompletionsLoadRequested(
                                    authState.user.id,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Reintentar progreso de hoy'),
                            )
                          else
                            const LinearProgressIndicator(minHeight: 2),
                        ],
                        const SizedBox(height: AppSpacing.xl),
                        Text(
                          'Tus hábitos',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        HabitList(
                          habits: habitState.habits,
                          ownerId: authState.user.id,
                          completions: completions,
                          completionsLoaded: completionsLoaded,
                          onCreateHabit: () =>
                              _openCreateHabit(context, authState.user.id),
                        ),
                      ],
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _openCreateHabit(BuildContext context, String ownerId) async {
    final created = await context.push<bool>('/habits/create');

    if (!context.mounted || created != true) {
      return;
    }

    context.read<HabitBloc>().add(HabitLoadRequested(ownerId));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Hábito creado')));
  }
}
