part of 'journal_screen_bloc.dart';

@immutable
abstract class JournalScreenEvent {}

class GetUsersList extends JournalScreenEvent {}

class GetLessonsList extends JournalScreenEvent {}

class AddLesson extends JournalScreenEvent {}

class AddPoint extends JournalScreenEvent {
  final Point editPoint;
  final String newPointValue;

  AddPoint(this.editPoint, this.newPointValue);
}

class EditLessonContents extends JournalScreenEvent {
  final LessonData editLesson;
  final String newLessonContents;

  EditLessonContents(this.editLesson, this.newLessonContents);
}

class EditLessonHomeTask extends JournalScreenEvent {
  final LessonData editLesson;
  final String newHomeTask;

  EditLessonHomeTask(this.editLesson, this.newHomeTask);
}


class EditLessonDate extends JournalScreenEvent {
  final LessonData editLesson;
  final DateTime newDate;

  EditLessonDate(this.editLesson, this.newDate);
}