
import 'package:journal/domain/entities/user.dart';


abstract class UserRepository {
  Future <List<User>> getUsersList ();
}