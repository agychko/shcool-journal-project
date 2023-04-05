import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journal/data/remote/model/api_user.dart';

import 'package:http/http.dart' as http;
import 'package:journal/data/response/data_response.dart';

import '../../../domain/entities/user.dart';

const String server = 'http://localhost:3000';

class UserApiSource {
  Future<DataResponse<List<User>>> getUsersList() async {
    try {
      var url = Uri.parse('$server/v1/users');
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
      var jsonResponse = jsonDecode(response.body);
      var apiUsersList = ApiUsersList.fromJson(jsonResponse);
      return Future.delayed(
        const Duration(milliseconds: 200),
        () => DataResponse.success(
          List.generate(
              apiUsersList.apiUsers.length,
              (index) => User(
                    id: apiUsersList.apiUsers[index].id!,
                    firstName: apiUsersList.apiUsers[index].firstName!,
                    lastName: apiUsersList.apiUsers[index].lastName!,
                    email: apiUsersList.apiUsers[index].email!,
                  )),
        ),
      );
    } catch (error) {
      return DataResponse.error(error.toString());
    }
  }

  void signUpUser({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email
  }) async {
    ApiUser user =
        ApiUser(id: '', firstName: firstName, lastName: lastName, email: email);
    var url = Uri.parse('$server/v1/users/create');
    await http.post(
      url,
      body: jsonEncode(user.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
