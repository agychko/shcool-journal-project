import 'dart:convert';

import 'package:journal/data/remote/model/api_user.dart';

import 'package:http/http.dart' as http;

import '../../../domain/entities/user.dart';

const String server = 'http://localhost:3000';

class UserApiSource {
  Future<List<User>> getUsersList() async {
      var url = Uri.parse('$server/v1/users');
      var response = await http.get(url);
      if (response.statusCode==200) {
        var jsonResponse = jsonDecode(response.body);
        var apiUsersList = ApiUsersList.fromJson(jsonResponse);
        return List.generate(
            apiUsersList.apiUsers.length,
                (index) => User(
                    id: apiUsersList.apiUsers[index].id!,
                    firstName: apiUsersList.apiUsers[index].firstName!,
                    lastName: apiUsersList.apiUsers[index].lastName!,
                    email: apiUsersList.apiUsers[index].email!,
                )
        );
      } else {
        throw Exception('bad request');
      }
    }
  }
