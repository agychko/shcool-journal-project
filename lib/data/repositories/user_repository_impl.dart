import 'package:journal/data/remote/source/user_api_source.dart';
import 'package:journal/data/response/data_response.dart';
import 'package:journal/domain/entities/user.dart';
import 'package:journal/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserApiSource _userApiSource;

  UserRepositoryImpl(this._userApiSource);

  @override
  Future <DataResponse<List<User>>> getUsersList() async {
    var userResponse = await _userApiSource.getUsersList();
    if (userResponse.isSuccess()) {
      var userList = userResponse.asSuccess().data;
      return DataResponse.success(userList);
    }
    return DataResponse.error(userResponse.asError().errorMessage);
  }
}
