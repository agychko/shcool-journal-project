import 'package:journal/domain/entities/lesson.dart';
import '../../models/response/data_response.dart';

abstract class LessonsSource {

  Future<DataResponse<List<Lesson>>> getLessonsList(String? accessToken);

  void setApiLesson(String? accessToken, Lesson lesson);

  void updateApiLesson(String? accessToken, Lesson lesson);
}
