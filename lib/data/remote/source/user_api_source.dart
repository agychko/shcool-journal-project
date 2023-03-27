import 'dart:convert';
import 'dart:io';

import 'package:journal/data/remote/model/api_user.dart';

import 'package:http/http.dart' as http;
import 'package:journal/data/response/data_response.dart';

import '../../../domain/entities/user.dart';

const String server = 'http://localhost:3000';

class UserApiSource {
  Future<DataResponse<List<User>>> getUsersList() async {
    try {
      var url = Uri.parse('$server/v1/users');
      var response = await http.get(url);
      var jsonResponse = jsonDecode(response.body);
      var apiUsersList = ApiUsersList.fromJson(jsonResponse);
      return Future.delayed(
        const Duration(milliseconds: 500),
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
    } on SocketException {
      return DataResponse.error('Connection Error');
    } on HttpException {
      return DataResponse.error('Http Error');
    } on FormatException {
      return DataResponse.error('Bad Request');
    } catch (error) {
      return DataResponse.error('Unknown Error. $error');
    }
  }
}
