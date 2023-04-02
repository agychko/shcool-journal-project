import 'package:journal/data/response/data_response.dart';
import 'package:journal/domain/entities/lesson_data.dart';

abstract class LessonsRepository {
  Future<DataResponse<List<LessonData>>> getLessonsList();
}