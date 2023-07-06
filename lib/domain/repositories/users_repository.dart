
import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/domain/entities/user.dart';


abstract class UsersRepository {

  Future <DataResponse<List<User>>> getUsersList ();

}