
import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/domain/entities/student.dart';


abstract class UserRepository {

  Future <DataResponse<List<Student>>> getUsersList ();

}