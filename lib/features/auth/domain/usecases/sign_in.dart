import 'package:habit_level/features/auth/domain/entities/auth_user.dart';
import 'package:habit_level/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';


@injectable
class SignIn {
  final AuthRepository repository;

  const SignIn(this.repository);
  Future <AuthUser> call({
    required String email,
    required String password,
  }) {
    return repository.signIn(email: email, password: password);
  }
}