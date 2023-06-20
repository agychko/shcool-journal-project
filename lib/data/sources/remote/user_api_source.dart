import 'dart:convert';
import 'dart:io';

import 'package:journal/data/models/remote/api_user.dart';

import 'package:http/http.dart' as http;
import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/utils/constants.dart';

import '../../../domain/entities/student.dart';

String server = Constants.appServer;

class UserApiSource {
  Future<DataResponse<List<Student>>> getUsersList(String accessToken) async {
    try {
      var url = Uri.parse('$server/v1/users');
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      });
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var apiUsersList = ApiUsersList.fromJson(jsonResponse['data']);
        return Future.delayed(
          const Duration(milliseconds: 200),
          () => DataResponse.success(
            List.generate(
                apiUsersList.apiUsers.length,
                (index) => Student(
                      id: apiUsersList.apiUsers[index].id!,
                      firstName: apiUsersList.apiUsers[index].firstName!,
                      lastName: apiUsersList.apiUsers[index].lastName!,
                    )),
          ),
        );
      } else {
        final message = jsonDecode(response.body)['message'];
        throw HttpException(message);
      }
    } catch (error) {
      return DataResponse.error(error.toString());
    }
  }
}
