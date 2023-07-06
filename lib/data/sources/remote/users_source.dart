
import 'package:journal/data/models/response/data_response.dart';

import '../../../domain/entities/user.dart';

abstract class UsersSource {

  Future<DataResponse<List<User>>> getUsersList(String accessToken);

}
