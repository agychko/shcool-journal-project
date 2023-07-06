import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:journal/domain/entities/lesson.dart';
import 'package:journal/domain/entities/point.dart';
import 'package:journal/domain/entities/user.dart';
import 'package:journal/domain/use_cases/get_lessons_list_use_case.dart';
import 'package:journal/domain/use_cases/get_points_list_use_case.dart';
import 'package:journal/domain/use_cases/get_users_list_use_case.dart';
import 'package:journal/domain/use_cases/set_lesson_use_case.dart';
import 'package:journal/domain/use_cases/set_point_use_case.dart';
import 'package:journal/domain/use_cases/update_lesson_use_case.dart';
import 'package:meta/meta.dart';


part 'journal_screen_event.dart';

part 'journal_screen_state.dart';

class JournalScreenBloc extends Bloc<JournalScreenEvent, JournalScreenState> {
  final GetUsersListUseCase _getUsersListUseCase = GetIt.instance<GetUsersListUseCase>();
  final GetLessonsListUseCase _getLessonsListUseCase = GetIt.instance<GetLessonsListUseCase>();
  final GetPointsListUseCase _getPointsListUseCase = GetIt.instance<GetPointsListUseCase>();
  final SetPointUseCase _setPointUseCase = GetIt.instance<SetPointUseCase>();
  final SetLessonUseCase _setLessonUseCase = GetIt.instance<SetLessonUseCase>();
  final UpdateLessonUseCase _updateLessonUseCase = GetIt.instance<UpdateLessonUseCase>();

  List<Lesson> lessons = [];
  List<User> users = [];
  List<Point> points = [];

  JournalScreenBloc() : super(JournalScreenInitial()) {
    on<GetUsersList>((event, emit) => _getStudentsList(emit));
    on<AddLesson>((event, emit) => _addLesson(emit));
    on<EditLessonContents>((event, emit) => _editLessonContents(event, emit));
    on<EditLessonHomeTask>((event, emit) => _editLessonHomeTask(event, emit));
    on<EditLessonDate>((event, emit) => _editLessonDate(event, emit));
    on<AddPoint>((event, emit) => _addPoint(event, emit));

    add(GetUsersList());
  }

  void _getStudentsList(Emitter<JournalScreenState> emit) async {
    emit(JournalScreenLoading());
    var usersData = await _getUsersListUseCase();
    var lessonsData = await _getLessonsListUseCase();
    var pointsData = await _getPointsListUseCase();
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
    _setPointUseCase(newPoint);
    emit(JournalScreenLoading());
    var pointsData = await _getPointsListUseCase();
    if(pointsData.isSuccess()) {
      var pointsList = pointsData.asSuccess().data;
      points = List.of(pointsList);
      emit(JournalScreenSuccess(users, lessons, points));
    } else {
      emit(JournalScreenError(pointsData.asError().errorMessage));
    }
  }

  void _addLesson(Emitter<JournalScreenState> emit) async {
    final newLesson = Lesson(
        id: '', dateTime: DateTime.now(), contents: '', homeTask: '');
    _setLessonUseCase(newLesson);
    emit(JournalScreenLoading());
    var lessonsData = await _getLessonsListUseCase();
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
    final updatedLessonData = Lesson(
        id: event.editLesson.id,
        dateTime: event.editLesson.dateTime,
        contents: event.newLessonContents,
        homeTask: event.editLesson.homeTask,
    );
    _updateLessonUseCase(updatedLessonData);
    emit(JournalScreenLoading());
    var lessonsData = await _getLessonsListUseCase();
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
    final updatedLesson = Lesson(
      id: event.editLesson.id,
      dateTime: event.editLesson.dateTime,
      contents: event.editLesson.contents,
      homeTask: event.newHomeTask,
    );
    _updateLessonUseCase(updatedLesson);
    emit(JournalScreenLoading());
    var lessonsData = await _getLessonsListUseCase();
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
    final updatedLesson = Lesson(
      id: event.editLesson.id,
      dateTime: event.newDate,
      contents: event.editLesson.contents,
      homeTask: event.editLesson.homeTask,
    );
    _updateLessonUseCase(updatedLesson);
    emit(JournalScreenLoading());
    var lessonsData = await _getLessonsListUseCase();
    if(lessonsData.isSuccess()) {
      var lessonsList = lessonsData.asSuccess().data;
      lessons = List.of(lessonsList);
      emit(JournalScreenSuccess(users, lessons, points));
    } else {
      emit(JournalScreenError(lessonsData.asError().errorMessage));
    }
  }
}
