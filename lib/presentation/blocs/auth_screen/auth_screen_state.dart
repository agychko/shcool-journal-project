part of 'auth_screen_bloc.dart';

@immutable
abstract class AuthScreenState {}

class AuthScreenInitial extends AuthScreenState {}

class AuthScreenLoading extends AuthScreenState {}

class AuthScreenError extends AuthScreenState {}

class AuthScreenSuccess extends AuthScreenState {}
