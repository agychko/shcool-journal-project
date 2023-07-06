import 'dart:convert';

import 'package:journal/data/models/mapper/lesson_mapper.dart';
import 'package:journal/data/models/remote/api_lesson.dart';
import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/data/sources/remote/lessons_source.dart';
import 'package:journal/domain/entities/lesson.dart';
import 'package:http/http.dart' as http;
import 'package:journal/utils/constants.dart';

String server = Constants.appServer;

class LessonsSourceImpl extends LessonsSource {

  @override
  Future<DataResponse<List<Lesson>>> getLessonsList(String? accessToken) async {
    try {
      var url = Uri.parse('$server/v1/lessons');
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      });
      var jsonResponse = jsonDecode(response.body);
      var apiLessonsList = ApiLessonsList.fromJson(jsonResponse);

      return Future.delayed(
          const Duration(milliseconds: 200),
          () => DataResponse.success(List.generate(
              apiLessonsList.apiLessons.length,
              (index) =>
                  LessonMapper.fromApi(apiLessonsList.apiLessons[index]))));
    } catch (error) {
      return DataResponse.error(error.toString());
    }
  }

  @override
  void setApiLesson(String? accessToken, Lesson lesson) async {
    ApiLesson apiLesson = LessonMapper.toApi(lesson);
    var url = Uri.parse('$server/v1/lessons/create');
    await http.post(
      url,
      body: jsonEncode(apiLesson.toCreateJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );
  }

  @override
  void updateApiLesson(String? accessToken, Lesson lesson) async {
    ApiLesson apiLesson = LessonMapper.toApi(lesson);
    var url = Uri.parse('$server/v1/lessons/update');
    await http.post(
      url,
      body: jsonEncode(apiLesson.toUpdateJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );
  }
}
