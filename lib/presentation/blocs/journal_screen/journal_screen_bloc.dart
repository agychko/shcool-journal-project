import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/data/remote/source/lesson_api_source.dart';
import 'package:journal/data/remote/source/user_api_source.dart';
import 'package:journal/data/repositories/lessons_repository_impl.dart';
import 'package:journal/data/repositories/user_repository_impl.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/lesson_data.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/lessons_repository.dart';
import '../../../domain/repositories/user_repository.dart';

part 'journal_screen_event.dart';

part 'journal_screen_state.dart';

class JournalScreenBloc extends Bloc<JournalScreenEvent, JournalScreenState> {
  final UserRepository _userRepository = UserRepositoryImpl(UserApiSource());
  final LessonsRepository _lessonsRepository = LessonsRepositoryImpl(LessonApiSource());

  JournalScreenBloc() : super(JournalScreenInitial()) {

    on<GetUsersList>((event, emit) => _getUsersList(emit));

    add(GetUsersList());
  }

  void _getUsersList(Emitter<JournalScreenState> emit) async {
    emit(JournalScreenLoading());
    var usersData = await _userRepository.getUsersList();
    var lessonsData = await _lessonsRepository.getLessonsList();
    if (usersData.isSuccess()&& lessonsData.isSuccess()) {
      var usersList = usersData.asSuccess().data;
      var lessonsList = lessonsData.asSuccess().data;
      emit(JournalScreenSuccess(usersList, lessonsList));
    } else {
      emit(JournalScreenError(usersData
          .asError()
          .errorMessage));
    }
  }
}
