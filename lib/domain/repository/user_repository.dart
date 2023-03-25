
import 'package:journal/data/remote/model/api_user.dart';


abstract class UserRepository {
  Future <ApiUsersList> getUsersList ();
}