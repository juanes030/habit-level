import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_level/core/di/injection.dart';
import 'package:habit_level/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:habit_level/features/habits/presentation/bloc/habit/habit_bloc.dart';
import 'package:habit_level/features/habits/presentation/pages/create_habit_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;

    if (authState is! AuthAuthenticated) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return BlocProvider(
      create: (_) =>
          getIt<HabitBloc>()..add(HabitLoadRequested(authState.user.id)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthSignOutRequested());
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: BlocBuilder<HabitBloc, HabitState>(
          builder: (context, state) {
            if (state is HabitLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HabitError) {
              return Center(child: Text(state.message));
            }

            if (state is HabitLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Mis hábitos',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    if (state.habits.isEmpty)
                      const Text('No tienes hábitos todavía.')
                    else
                      ...state.habits.map(
                        (habit) => ListTile(
                          title: Text(habit.title),
                          subtitle: Text(habit.description),
                          trailing: Text('${habit.target} ${habit.unit}'),
                        ),
                      ),

                    const Divider(height: 32),

                    CreateHabitForm(ownerId: authState.user.id),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
