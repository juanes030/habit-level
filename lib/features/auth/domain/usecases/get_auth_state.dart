import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';


@injectable
class GetAuthState {
  final AuthRepository repository;

  const GetAuthState(this.repository);

  Stream<AuthUser?> call() {
    return repository.authStateChanges;
  }
}