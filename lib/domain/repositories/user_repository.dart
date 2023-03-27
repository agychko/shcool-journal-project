
import 'package:journal/data/response/data_response.dart';
import 'package:journal/domain/entities/user.dart';


abstract class UserRepository {
  Future <DataResponse<List<User>>> getUsersList ();
}