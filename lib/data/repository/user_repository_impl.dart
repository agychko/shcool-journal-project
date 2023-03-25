import 'package:journal/data/remote/model/api_user.dart';
import 'package:journal/data/remote/source/user_api_source.dart';
import 'package:journal/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserApiSource _userApiSource;

  UserRepositoryImpl(this._userApiSource);

  @override
  Future<ApiUsersList> getUsersList() async {
    var userList = await _userApiSource.getUsersList();
    return userList;
  }
}
