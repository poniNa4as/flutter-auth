import 'package:auth_clean_arch/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepository _repo;

  LoginUseCase(this._repo);

  Future<String> call(String email, String password) {
    return _repo.login(email, password);
  }
}
