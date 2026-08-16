import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_level/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:habit_level/features/auth/presentation/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Iniciar sesión')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const LoginForm(),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.go('/register');
                },
                child: const Text('¿No tienes una cuenta? Crear cuenta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
