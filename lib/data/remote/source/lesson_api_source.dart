import 'dart:convert';

import 'package:journal/data/mapper/lesson_mapper.dart';
import 'package:journal/data/remote/model/api_lesson.dart';
import 'package:journal/domain/entities/lesson_data.dart';
import 'package:http/http.dart' as http;
import '../../response/data_response.dart';

const String server = 'http://localhost:3000';

class LessonApiSource {
  Future<DataResponse<List<LessonData>>> getLessonsList() async {
    try {
      var url = Uri.parse('$server/v1/lessons');
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
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

  void setApiLesson(LessonData lessonData) async {
    ApiLesson apiLesson = LessonMapper.toApi(lessonData);
    var url = Uri.parse('$server/v1/lessons/create');
    await http.post(
        url,
      body: jsonEncode(apiLesson.toCreateJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  void updateApiLesson(LessonData lessonData) async {
    ApiLesson apiLesson = LessonMapper.toApi(lessonData);
    var url = Uri.parse('$server/v1/lessons/update');
    await http.post(
      url,
      body: jsonEncode(apiLesson.toUpdateJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
