import 'package:journal/data/models/response/data_response.dart';
import '../../models/response/auth_response.dart';

abstract class AuthSource {

  void signUpUser(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}
      );

  Future<DataResponse<AuthResponse>> login(String email, String password);

  Future<DataResponse<String>> refresh (String refreshToken);
}
