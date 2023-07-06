import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/domain/entities/user.dart';
import 'package:journal/domain/repositories/users_repository.dart';

class GetUsersListUseCase {
  final UsersRepository _usersRepository;

  GetUsersListUseCase(this._usersRepository);

  Future<DataResponse<List<User>>> call() => _usersRepository.getUsersList();
}
