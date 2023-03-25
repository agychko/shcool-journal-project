import 'dart:convert';

import 'package:journal/data/remote/model/api_user.dart';

import 'package:http/http.dart' as http;

const String server = 'http:localhost:3000';

class UserApiSource {
  Future<ApiUsersList> getUsersList() async {
      var url = Uri.parse('$server/v1/users');
      var response = await http.get(url);
      if (response.statusCode==200) {
        return ApiUsersList.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('bad request');
      }
    }
  }
