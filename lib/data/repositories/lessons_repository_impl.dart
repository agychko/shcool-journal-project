import 'package:journal/data/sources/local/preferences_source.dart';
import 'package:journal/data/sources/remote/lessons_source.dart';
import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/domain/entities/lesson.dart';
import 'package:journal/domain/repositories/lessons_repository.dart';

class LessonsRepositoryImpl extends LessonsRepository {
  final LessonsSource _lessonsSource;
  final PreferencesSource _preferencesSource;

  LessonsRepositoryImpl(this._lessonsSource, this._preferencesSource);

  @override
  Future<DataResponse<List<Lesson>>> getLessonsList() async {
    String accessToken = await _preferencesSource.getAccessToken() ?? '';
    var lessonResponse = await _lessonsSource.getLessonsList(accessToken);
    if (lessonResponse.isSuccess()) {
      var lessonsList = lessonResponse.asSuccess().data;
      return DataResponse.success(lessonsList);
    } else {
      return DataResponse.error(lessonResponse.asError().errorMessage);
    }
  }

  @override
  void setLesson(Lesson lesson) async {
    String accessToken = await _preferencesSource.getAccessToken() ?? '';
    _lessonsSource.setApiLesson(accessToken, lesson);
  }

  @override
  void updateLesson(Lesson lesson) async {
    String accessToken = await _preferencesSource.getAccessToken() ?? '';
    _lessonsSource.updateApiLesson(accessToken, lesson);
  }

}