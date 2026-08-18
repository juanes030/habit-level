import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_level/core/di/injection.dart';
import 'package:habit_level/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:habit_level/features/habits/presentation/bloc/habit/habit_bloc.dart';
import 'package:habit_level/features/habits/presentation/bloc/habit_completion/habit_completion_bloc.dart';
import 'package:habit_level/features/habits/presentation/pages/create_habit_form.dart';
import 'package:habit_level/features/habits/presentation/widgets/habit_list.dart';

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
        BlocProvider(create: (_) => getIt<HabitCompletionBloc>()),
      ],
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mis hábitos',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      HabitList(
                        habits: state.habits,
                        ownerId: authState.user.id,
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
      ),
    );
  }
}
