import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:journal/data/models/response/auth_response.dart';
import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/data/sources/remote/auth_source.dart';
import 'package:journal/utils/constants.dart';


String server = Constants.appServer;

class AuthSourceImpl extends AuthSource {

  @override
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

  @override
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
      if (response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(jsonResponse);
        return DataResponse.success(authResponse);
      } else {
        final message = jsonResponse['message'];
        throw HttpException(message);
      } } catch (error) {
      return DataResponse.error(error.toString());
    }
  }

  @override
  Future<DataResponse<String>> refresh (String refreshToken) async {
    try {
      return DataResponse.success(refreshToken);
    } catch(error) {
      return DataResponse.error(error.toString());
    }
  }
}
