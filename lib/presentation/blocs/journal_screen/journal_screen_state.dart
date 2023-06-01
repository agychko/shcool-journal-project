part of 'journal_screen_bloc.dart';

@immutable
abstract class JournalScreenState {}

class JournalScreenInitial extends JournalScreenState {}

class JournalScreenLoading extends JournalScreenState {}

class JournalScreenError extends JournalScreenState {
  final String errorMessage;

  JournalScreenError(this.errorMessage);
}

class JournalScreenSuccess extends JournalScreenState {
  final List<Student> usersData;
  final List<Lesson> lessonData;
  final List<Point> pointsData;

  JournalScreenSuccess(this.usersData, this.lessonData, this.pointsData);
}
