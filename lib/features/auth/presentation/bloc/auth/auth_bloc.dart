import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_level/features/auth/domain/entities/auth_user.dart';
import 'package:habit_level/features/auth/domain/failures/auth_failure.dart';
import 'package:habit_level/features/auth/domain/usecases/get_auth_state.dart';
import 'package:habit_level/features/auth/domain/usecases/send_password_reset_email.dart';
import 'package:habit_level/features/auth/domain/usecases/sign_in.dart';
import 'package:habit_level/features/auth/domain/usecases/sign_out.dart';
import 'package:habit_level/features/auth/domain/usecases/sign_up.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthState _getAuthState;
  final SignIn _signIn;
  final SignUp _signUp;
  final SignOut _signOut;
  final SendPasswordResetEmail _sendPasswordResetEmail;

  StreamSubscription<AuthUser?>? _authSubscription;

  AuthBloc(
    this._getAuthState,
    this._signIn,
    this._signUp,
    this._signOut,
    this._sendPasswordResetEmail,
  ) : super(const AuthInitial()) {
    on<AuthStateChanged>(_onAuthStateChanged);
    on<AuthSignInRequested>(_onSignInRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);
    on<AuthPasswordResetRequested>(_onPasswordResetRequested);

    _authSubscription = _getAuthState().listen(
      (user) => add(AuthStateChanged(user)),
    );
  }

  void _onAuthStateChanged(AuthStateChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(AuthAuthenticated(event.user!));
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final user = await _signIn(email: event.email, password: event.password);

      emit(AuthAuthenticated(user));
    } on AuthFailure catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(const AuthError('Ocurrió un error inesperado.'));
    }
  }

  Future<void> _onSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final user = await _signUp(email: event.email, password: event.password);

      emit(AuthAuthenticated(user));
    } on AuthFailure catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(const AuthError('Ocurrió un error inesperado.'));
    }
  }

  Future<void> _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await _signOut();
    } on AuthFailure catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(const AuthError('Ocurrió un error inesperado.'));
    }
  }

  Future<void> _onPasswordResetRequested(
    AuthPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await _sendPasswordResetEmail(event.email);
      emit(const AuthUnauthenticated());
    } on AuthFailure catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(const AuthError('Ocurrió un error inesperado.'));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
