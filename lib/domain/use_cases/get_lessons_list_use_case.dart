import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/domain/entities/lesson.dart';
import 'package:journal/domain/repositories/lessons_repository.dart';

class GetLessonsListUseCase {
  final LessonsRepository _lessonsRepository;

  GetLessonsListUseCase(this._lessonsRepository);

  Future<DataResponse<List<Lesson>>> call() =>
      _lessonsRepository.getLessonsList();
}