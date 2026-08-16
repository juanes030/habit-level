import '../repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignOut {
  final AuthRepository repository;

  const SignOut(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}