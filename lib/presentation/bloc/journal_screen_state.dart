part of 'journal_screen_bloc.dart';

@immutable
abstract class JournalScreenState {}

class JournalScreenInitial extends JournalScreenState {}

class JournalScreenLoading extends JournalScreenState {}

class JournalScreenError extends JournalScreenState {}

class JournalScreenSuccess extends JournalScreenState {
  final List<User> usersData;
  JournalScreenSuccess(this.usersData);
}
