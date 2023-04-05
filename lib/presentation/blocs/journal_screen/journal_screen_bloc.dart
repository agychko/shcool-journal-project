import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/data/remote/source/lesson_api_source.dart';
import 'package:journal/data/remote/source/point_api_source.dart';
import 'package:journal/data/remote/source/user_api_source.dart';
import 'package:journal/data/repositories/lessons_repository_impl.dart';
import 'package:journal/data/repositories/points_repository_impl.dart';
import 'package:journal/data/repositories/user_repository_impl.dart';
import 'package:journal/domain/entities/point.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/lesson_data.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/lessons_repository.dart';
import '../../../domain/repositories/points_repository.dart';
import '../../../domain/repositories/user_repository.dart';

part 'journal_screen_event.dart';

part 'journal_screen_state.dart';

class JournalScreenBloc extends Bloc<JournalScreenEvent, JournalScreenState> {
  final UserRepository _userRepository = UserRepositoryImpl(UserApiSource());
  final LessonsRepository _lessonsRepository =
      LessonsRepositoryImpl(LessonApiSource());
  final PointsRepository _pointsRepository = PointsRepositoryImpl(PointApiSource());
  List<LessonData> lessons = [];
  List<User> users = [];
  List<Point> points = [];

  JournalScreenBloc() : super(JournalScreenInitial()) {
    on<GetUsersList>((event, emit) => _getUsersList(emit));
    on<AddLesson>((event, emit) => _addLesson(emit));
    on<EditLessonContents>((event, emit) => _editLessonContents(event, emit));
    on<EditLessonHomeTask>((event, emit) => _editLessonHomeTask(event, emit));
    on<EditLessonDate>((event, emit) => _editLessonDate(event, emit));
    on<AddPoint>((event, emit) => _addPoint(event, emit));

    add(GetUsersList());
  }

  void _getUsersList(Emitter<JournalScreenState> emit) async {
    emit(JournalScreenLoading());
    var usersData = await _userRepository.getUsersList();
    var lessonsData = await _lessonsRepository.getLessonsList();
    var pointsData = await _pointsRepository.getPointsList();
    if (usersData.isSuccess() && lessonsData.isSuccess() && pointsData.isSuccess()){
      var usersList = usersData.asSuccess().data;
      var lessonsList = lessonsData.asSuccess().data;
      var pointsList = pointsData.asSuccess().data;
      lessons = List.of(lessonsList);
      users = List.of(usersList);
      points = List.of(pointsList);
      emit(JournalScreenSuccess(users, lessons, points));
    } else {
      emit(JournalScreenError(usersData.asError().errorMessage));
    }
  }

  void _addPoint(AddPoint event, Emitter<JournalScreenState> emit) async {
    final newPoint = Point(
        id: event.editPoint.id,
        userId: event.editPoint.userId,
        lessonId: event.editPoint.lessonId,
        value: event.newPointValue,
    );
    _pointsRepository.setApiPoint(newPoint);
    emit(JournalScreenLoading());
    var pointsData = await _pointsRepository.getPointsList();
    if(pointsData.isSuccess()) {
      var pointsList = pointsData.asSuccess().data;
      points = List.of(pointsList);
      emit(JournalScreenSuccess(users, lessons, points));
    } else {
      emit(JournalScreenError(pointsData.asError().errorMessage));
    }
  }

  void _addLesson(Emitter<JournalScreenState> emit) async {
    final newLessonData = LessonData(
        id: '', dateTime: DateTime.now(), contents: '', homeTask: '');
    _lessonsRepository.setApiLesson(newLessonData);
    emit(JournalScreenLoading());
    var lessonsData = await _lessonsRepository.getLessonsList();
    if(lessonsData.isSuccess()) {
      var lessonsList = lessonsData.asSuccess().data;
      lessons = List.of(lessonsList);
      emit(JournalScreenSuccess(users, lessons, points));
    } else {
      emit(JournalScreenError(lessonsData.asError().errorMessage));
    }
  }

  void _editLessonContents(
      EditLessonContents event, Emitter<JournalScreenState> emit) async {
    final updatedLessonData = LessonData(
        id: event.editLesson.id,
        dateTime: event.editLesson.dateTime,
        contents: event.newLessonContents,
        homeTask: event.editLesson.homeTask,
    );
    _lessonsRepository.updateApiLesson(updatedLessonData);
    emit(JournalScreenLoading());
    var lessonsData = await _lessonsRepository.getLessonsList();
    if(lessonsData.isSuccess()) {
      var lessonsList = lessonsData.asSuccess().data;
      lessons = List.of(lessonsList);
      emit(JournalScreenSuccess(users, lessons, points));
    } else {
      emit(JournalScreenError(lessonsData.asError().errorMessage));
    }
  }

  void _editLessonHomeTask(
      EditLessonHomeTask event, Emitter<JournalScreenState> emit) async {
    final updatedLessonData = LessonData(
      id: event.editLesson.id,
      dateTime: event.editLesson.dateTime,
      contents: event.editLesson.contents,
      homeTask: event.newHomeTask,
    );
    _lessonsRepository.updateApiLesson(updatedLessonData);
    emit(JournalScreenLoading());
    var lessonsData = await _lessonsRepository.getLessonsList();
    if(lessonsData.isSuccess()) {
      var lessonsList = lessonsData.asSuccess().data;
      lessons = List.of(lessonsList);
      emit(JournalScreenSuccess(users, lessons, points));
    } else {
      emit(JournalScreenError(lessonsData.asError().errorMessage));
    }
  }

  void _editLessonDate(
      EditLessonDate event, Emitter<JournalScreenState> emit) async {
    final updatedLessonData = LessonData(
      id: event.editLesson.id,
      dateTime: event.newDate,
      contents: event.editLesson.contents,
      homeTask: event.editLesson.homeTask,
    );
    _lessonsRepository.updateApiLesson(updatedLessonData);
    emit(JournalScreenLoading());
    var lessonsData = await _lessonsRepository.getLessonsList();
    if(lessonsData.isSuccess()) {
      var lessonsList = lessonsData.asSuccess().data;
      lessons = List.of(lessonsList);
      emit(JournalScreenSuccess(users, lessons, points));
    } else {
      emit(JournalScreenError(lessonsData.asError().errorMessage));
    }
  }
}
