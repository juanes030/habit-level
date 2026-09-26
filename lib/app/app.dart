import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_level/app/router/app_router.dart';
import 'package:habit_level/app/theme/app_theme.dart';
import 'package:habit_level/core/di/injection.dart';
import 'package:habit_level/features/auth/presentation/bloc/auth/auth_bloc.dart';

class HabitLevelApp extends StatelessWidget {
  const HabitLevelApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt<AuthBloc>();

    return BlocProvider.value(
      value: authBloc,
      child: MaterialApp.router(
        title: 'HabitLevel',
        routerConfig: createAppRouter(authBloc),
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
