import 'package:journal/domain/entities/lesson.dart';

import '../remote/api_lesson.dart';

class LessonMapper {
  static Lesson fromApi(ApiLesson apiLesson) {
    return Lesson(
      id: apiLesson.id!,
      dateTime: DateTime.tryParse(apiLesson.dateTime!)!,
      contents: apiLesson.contents!,
      homeTask: apiLesson.homeTask!,
    );
  }

  static ApiLesson toApi(Lesson lesson) {
    return ApiLesson(
        id: lesson.id,
        dateTime: lesson.dateTime.toString(),
        contents: lesson.contents,
        homeTask: lesson.homeTask);
  }
}
