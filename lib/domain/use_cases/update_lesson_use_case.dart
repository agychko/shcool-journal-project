import 'package:journal/domain/entities/lesson.dart';
import 'package:journal/domain/repositories/lessons_repository.dart';

class UpdateLessonUseCase {
  final LessonsRepository _lessonsRepository;

  UpdateLessonUseCase(this._lessonsRepository);

  void call(Lesson lesson) =>
      _lessonsRepository.updateLesson(lesson);
}