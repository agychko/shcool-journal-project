part of 'journal_screen_bloc.dart';

@immutable
abstract class JournalScreenEvent {}

class GetUsersList extends JournalScreenEvent {}

class GetLessonsList extends JournalScreenEvent {}
