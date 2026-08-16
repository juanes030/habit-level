import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_level/features/auth/domain/failures/auth_failure.dart';

import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_user_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Stream<AuthUser?> get authStateChanges {
    return remoteDataSource.authStateChanges.map((user) {
      if (user == null) {
        return null;
      }

      return AuthUserModel.fromFirebaseUser(user);
    });
  }

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signIn(
        email: email,
        password: password,
      );

      return AuthUserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(_mapFirebaseAuthError(e.code));
    }
  }

  @override
  Future<AuthUser> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signUp(
        email: email,
        password: password,
      );

      return AuthUserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(_mapFirebaseAuthError(e.code));
    }
  }

  @override
  Future<void> signOut() {
    return remoteDataSource.signOut();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await remoteDataSource.sendPasswordResetEmail(email);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(_mapFirebaseAuthError(e.code));
    }
  }
}

String _mapFirebaseAuthError(String code) {
  switch (code) {
    case 'invalid-email':
      return 'El correo electrónico no es válido.';

    case 'user-not-found':
      return 'No encontramos una cuenta con este correo.';

    case 'wrong-password':
      return 'La contraseña es incorrecta.';

    case 'invalid-credential':
      return 'El correo o la contraseña son incorrectos.';

    case 'email-already-in-use':
      return 'Ya existe una cuenta con este correo.';

    case 'weak-password':
      return 'La contraseña es demasiado débil.';

    case 'user-disabled':
      return 'Esta cuenta ha sido deshabilitada.';

    case 'too-many-requests':
      return 'Demasiados intentos. Inténtalo nuevamente más tarde.';

    case 'missing-email':
      return 'Ingresa tu correo electrónico.';

    default:
      return 'Ocurrió un error de autenticación.';
  }
}
