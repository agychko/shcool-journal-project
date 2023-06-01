import 'package:journal/data/sources/local/preferences_source.dart';
import 'package:journal/data/sources/remote/user_api_source.dart';
import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/domain/entities/student.dart';
import 'package:journal/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserApiSource _userApiSource;
  final PreferencesSource _preferenceSource;

  UserRepositoryImpl(this._userApiSource, this._preferenceSource);

  @override
  Future <DataResponse<List<Student>>> getUsersList() async {
    String accessToken = await _preferenceSource.getAccessToken() ?? '';
    var userResponse = await _userApiSource.getUsersList(accessToken);
    if (userResponse.isSuccess()) {
      var userList = userResponse.asSuccess().data;
      return DataResponse.success(userList);
    }
    return DataResponse.error(userResponse.asError().errorMessage);
  }
}
