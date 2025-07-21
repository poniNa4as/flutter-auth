import 'package:injectable/injectable.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FlutterSecureStorage storage;

  AuthRepositoryImpl(this.storage);

  @override
  Future<String> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@test.com' && password == '123456') {
      const token = 'mock_token';
      await storage.write(key: 'token', value: token);
      return token;
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<void> logout() async {
    await storage.delete(key: 'token');
  }
}
