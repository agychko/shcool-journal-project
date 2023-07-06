import 'package:journal/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future call(String email, String password) =>
      _authRepository.login(email, password);

}