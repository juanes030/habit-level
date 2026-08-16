import 'package:habit_level/features/auth/domain/entities/auth_user.dart';


abstract class AuthRepository {
  Stream<AuthUser?> get authStateChanges;

  Future<AuthUser> signIn({required String email, required String password});

  Future<AuthUser> signUp({required String email, required String password});

  Future<void> signOut();

  Future<void> sendPasswordResetEmail(String email);
}
