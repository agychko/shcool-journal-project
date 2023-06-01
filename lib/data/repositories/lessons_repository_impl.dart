import 'package:journal/data/sources/remote/lesson_api_source.dart';
import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/domain/entities/lesson.dart';
import 'package:journal/domain/repositories/lessons_repository.dart';

class LessonsRepositoryImpl extends LessonsRepository {
  final LessonApiSource _lessonApiSource;

  LessonsRepositoryImpl(this._lessonApiSource);

  @override
  Future<DataResponse<List<Lesson>>> getLessonsList() async {
    var lessonResponse = await _lessonApiSource.getLessonsList();
    if (lessonResponse.isSuccess()) {
      var lessonsList = lessonResponse.asSuccess().data;
      return DataResponse.success(lessonsList);
    } else {
      return DataResponse.error(lessonResponse.asError().errorMessage);
    }
  }

  @override
  void setApiLesson(Lesson lesson) async {
    _lessonApiSource.setApiLesson(lesson);
  }

  @override
  void updateApiLesson(Lesson lesson) async {
    _lessonApiSource.updateApiLesson(lesson);
  }

}