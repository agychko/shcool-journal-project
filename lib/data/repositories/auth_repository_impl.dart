import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/data/models/response/auth_response.dart';
import 'package:journal/domain/repositories/auth_repository.dart';

import '../sources/local/preferences_source.dart';
import '../sources/remote/auth_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthSource _authSource;
  final PreferencesSource _preferenceSource;

  AuthRepositoryImpl(this._authSource, this._preferenceSource);

  @override
  Future <DataResponse<AuthResponse>> login(String email, String password) async {
    var loginResponse = await _authSource.login(email, password);
    if (loginResponse.isSuccess()) {
      var data = loginResponse.asSuccess().data;
      await _preferenceSource.setAccessToken(data.accessToken!);
      await _preferenceSource.setRefreshToken(data.refreshToken!);
      return DataResponse.success(data);
    }
    return DataResponse.error(loginResponse.asError().errorMessage);
  }

}