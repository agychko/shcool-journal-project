import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:journal/data/models/response/data_response.dart';
import 'package:journal/domain/use_cases/login_use_case.dart';
import 'package:meta/meta.dart';

part 'auth_screen_event.dart';

part 'auth_screen_state.dart';

class AuthScreenBloc extends Bloc<AuthScreenEvent, AuthScreenState> {
  final LoginUseCase _loginUseCase = GetIt.instance<LoginUseCase>();

  AuthScreenBloc() : super(AuthScreenInitial()) {
    on<Login>((event, emit) => _login(event, emit));
  }

  void _login(Login event, Emitter<AuthScreenState> emit) async {
    DataResponse loginResponse = await _loginUseCase(event.email, event.password);
    if (loginResponse.isSuccess()) {
      emit(AuthScreenSuccess());
    } else {
      emit(AuthScreenError());
    }
  }
}
