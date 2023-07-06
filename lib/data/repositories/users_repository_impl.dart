import 'package:journal/data/sources/local/preferences_source.dart';
import 'package:journal/data/sources/remote/users_source.dart';
import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/domain/entities/user.dart';
import 'package:journal/domain/repositories/users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {
  final UsersSource _usersSource;
  final PreferencesSource _preferencesSource;

  UsersRepositoryImpl(this._usersSource, this._preferencesSource);

  @override
  Future <DataResponse<List<User>>> getUsersList() async {
    String accessToken = await _preferencesSource.getAccessToken() ?? '';
    var userResponse = await _usersSource.getUsersList(accessToken);
    if (userResponse.isSuccess()) {
      var userList = userResponse.asSuccess().data;
      return DataResponse.success(userList);
    }
    return DataResponse.error(userResponse.asError().errorMessage);
  }
}
