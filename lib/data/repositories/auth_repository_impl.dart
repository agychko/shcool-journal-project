import 'package:journal/domain/repositories/auth_repository.dart';

import '../sources/local/preferences_source.dart';
import '../sources/remote/auth_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthSource _authSource;
  final PreferencesSource _preferenceSource;

  AuthRepositoryImpl(this._authSource, this._preferenceSource);

  @override
  Future login(String email, String password) async {
    var tokenResponse = await _authSource.login(email: email, password: password);
    await _preferenceSource.setAccessToken(tokenResponse['access_token']);
    await _preferenceSource.setRefreshToken(tokenResponse['refresh_token']);
  }

}