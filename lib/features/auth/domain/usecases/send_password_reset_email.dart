import '../repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendPasswordResetEmail {
  final AuthRepository repository;

  const SendPasswordResetEmail(this.repository);

  Future<void> call(String email) {
    return repository.sendPasswordResetEmail(email);
  }
}