import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/data/repositories/auth_repository_impl.dart';
import 'package:journal/data/sources/local/preferences_source.dart';
import 'package:journal/data/sources/remote/auth_source.dart';
import 'package:journal/domain/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_screen_event.dart';

part 'auth_screen_state.dart';

class AuthScreenBloc extends Bloc<AuthScreenEvent, AuthScreenState> {
  final AuthRepository _authRepository =
      AuthRepositoryImpl(AuthSource(), PreferencesSource());
  // bool successful = false;

  AuthScreenBloc() : super(AuthScreenInitial()) {
    on<Login>((event, emit) => _login(event, emit));
  }

  void _login(Login event, Emitter<AuthScreenState> emit) async {
    DataResponse loginResponse = await _authRepository.login(event.email, event.password);
    if (loginResponse.isSuccess()) {
      emit(AuthScreenSuccess());
    } else {
      emit(AuthScreenError());
    }
  }
}
