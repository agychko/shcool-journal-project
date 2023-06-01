import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../utils/constants.dart';
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

  Future login({required String email, required String password}) async {
    final request = { email: email, password: password };
    var url = Uri.parse('$server/v1/auth/login');
    var response = await http.post(
      url,
      body: jsonEncode(request),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
}
