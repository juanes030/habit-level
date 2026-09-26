import 'package:go_router/go_router.dart';
import 'package:habit_level/app/router/auth_router_refresh_stream.dart';
import 'package:habit_level/core/di/injection.dart';
import 'package:habit_level/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:habit_level/features/auth/presentation/pages/login_page.dart';
import 'package:habit_level/features/auth/presentation/pages/register_page.dart';
import 'package:habit_level/features/habits/presentation/pages/create_habit_page.dart';
import 'package:habit_level/features/home/presentation/pages/home_page.dart';

final authBloc = getIt<AuthBloc>();

GoRouter createAppRouter(AuthBloc authBloc) {
  return GoRouter(
    initialLocation: '/login',
    refreshListenable: AuthRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final isAuthenticated = authState is AuthAuthenticated;
      final isOnAuth =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (authState is AuthInitial || authState is AuthLoading) {
        return null;
      }

      if (!isAuthenticated && !isOnAuth) {
        return '/login';
      }

      if (isAuthenticated && isOnAuth) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/habits/create',
        builder: (context, state) => const CreateHabitPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
    ],
  );
}
