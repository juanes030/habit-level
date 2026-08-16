import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Stream<User?> get authStateChanges;

  Future<User> signIn({required String email, required String password});

  Future<User> signUp({required String email, required String password});

  Future<void> signOut();

  Future<void> sendPasswordResetEmail(String email);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  @override
  Future<User> signIn({required String email, required String password}) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential.user!;
  }

  @override
  Future<User> signUp({required String email, required String password}) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential.user!;
  }

  @override
  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
