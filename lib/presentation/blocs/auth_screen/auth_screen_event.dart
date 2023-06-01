part of 'auth_screen_bloc.dart';

@immutable
abstract class AuthScreenEvent {}

class Login extends AuthScreenEvent {
  final String email;
  final String password;

  Login(this.email, this.password);
}
