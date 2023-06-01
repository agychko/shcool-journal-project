import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/domain/entities/lesson.dart';

abstract class LessonsRepository {
  Future<DataResponse<List<Lesson>>> getLessonsList();
  void setApiLesson(Lesson lesson);
  void updateApiLesson(Lesson lesson);
}