import 'package:journal/data/remote/source/lesson_api_source.dart';
import 'package:journal/data/response/data_response.dart';
import 'package:journal/domain/entities/lesson_data.dart';
import 'package:journal/domain/repositories/lessons_repository.dart';

class LessonsRepositoryImpl extends LessonsRepository {
  final LessonApiSource _lessonApiSource;

  LessonsRepositoryImpl(this._lessonApiSource);

  @override
  Future<DataResponse<List<LessonData>>> getLessonsList() async {
    var lessonResponse = await _lessonApiSource.getLessonsList();
    if (lessonResponse.isSuccess()) {
      var lessonsList = lessonResponse.asSuccess().data;
      return DataResponse.success(lessonsList);
    } else {
      return DataResponse.error(lessonResponse.asError().errorMessage);
    }
  }

}