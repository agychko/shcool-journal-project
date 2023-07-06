import 'package:journal/domain/entities/lesson.dart';
import 'package:journal/domain/repositories/lessons_repository.dart';

class SetLessonUseCase {
  final LessonsRepository _lessonsRepository;

  SetLessonUseCase(this._lessonsRepository);

  void call(Lesson lesson) =>
      _lessonsRepository.setLesson(lesson);
}