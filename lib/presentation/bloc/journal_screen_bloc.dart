import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/data/remote/source/user_api_source.dart';
import 'package:journal/data/repository/user_repository_impl.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/user.dart';
import '../../domain/repository/user_repository.dart';

part 'journal_screen_event.dart';

part 'journal_screen_state.dart';

class JournalScreenBloc extends Bloc<JournalScreenEvent, JournalScreenState> {
  final UserRepository _userRepository = UserRepositoryImpl(UserApiSource());

  JournalScreenBloc() : super(JournalScreenInitial()) {

    on<GetUsersList>((event, emit) => _getUsersList(emit));

    add(GetUsersList());
  }

  void _getUsersList(Emitter<JournalScreenState> emit) async {
    emit(JournalScreenLoading());
    var usersData = await _userRepository.getUsersList();
    if (usersData.isSuccess()) {
      var usersList = usersData.asSuccess().data;
      emit(JournalScreenSuccess(usersList));
    }
    emit(JournalScreenError(usersData.asError().errorMessage));
  }
}
