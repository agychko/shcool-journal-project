import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:journal/data/models/response/data_response.dart';
import '../../../utils/constants.dart';
import '../../models/response/auth_response.dart';
import '../local/preferences_source.dart';

String server = Constants.appServer;

class AuthSource {
  final PreferencesSource preferencesSource = PreferencesSource();

  void signUpUser(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    final request = {
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    };
    var url = Uri.parse('$server/v1/auth/signup');
    await http.post(
      url,
      body: jsonEncode(request),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<DataResponse<AuthResponse>> login(String email, String password) async {
    try {
    final request = { "email": email, "password": password };
    var url = Uri.parse('$server/v1/auth/login');
    var response = await http.post(
      url,
      body: jsonEncode(request),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      AuthResponse authResponse = AuthResponse.fromJson(jsonResponse);
      return DataResponse.success(authResponse);
    } else {
      final message = jsonResponse['message'];
      throw HttpException(message);
    } } catch (error) {
      return DataResponse.error(error.toString());
    }
  }

  Future<DataResponse<String>> refresh (String refreshToken) async {
    try {
      return DataResponse.success(refreshToken);
    } catch(error) {
      return DataResponse.error(error.toString());
    }
  }
}
