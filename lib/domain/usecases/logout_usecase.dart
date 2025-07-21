import 'package:auth_clean_arch/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final AuthRepository _repo;

  LogoutUseCase(this._repo);

  Future<void> call() {
    return _repo.logout();
  }
}
