import 'package:journal/domain/entities/lesson_data.dart';

import '../remote/model/api_lesson.dart';

class LessonMapper {
  static LessonData fromApi(ApiLesson apiLesson) {
    return LessonData(
        dateTime: DateTime.tryParse(apiLesson.dateTime!)!,
        contents: apiLesson.contents!,
        homeTask: apiLesson.homeTask!,
    );
  }

  static ApiLesson toApi(LessonData lessonData) {
    return ApiLesson(
        id: '',
        dateTime: lessonData.dateTime.toString(),
        contents: lessonData.contents,
        homeTask: lessonData.homeTask
    );
  }
}