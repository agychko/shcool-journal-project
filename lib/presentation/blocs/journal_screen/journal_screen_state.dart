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
  final List<User> usersData;
  final List<LessonData> lessonData;

  JournalScreenSuccess(this.usersData, this.lessonData);
}
