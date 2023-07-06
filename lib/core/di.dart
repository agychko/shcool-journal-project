import 'package:get_it/get_it.dart';
import 'package:journal/data/repositories/auth_repository_impl.dart';
import 'package:journal/data/repositories/lessons_repository_impl.dart';
import 'package:journal/data/repositories/points_repository_impl.dart';
import 'package:journal/data/repositories/users_repository_impl.dart';
import 'package:journal/data/sources/local/impl/preferences_source_impl.dart';
import 'package:journal/data/sources/local/preferences_source.dart';
import 'package:journal/data/sources/remote/auth_source.dart';
import 'package:journal/data/sources/remote/impl/auth_source_impl.dart';
import 'package:journal/data/sources/remote/impl/lessons_source_impl.dart';
import 'package:journal/data/sources/remote/impl/points_source_impl.dart';
import 'package:journal/data/sources/remote/impl/users_source_impl.dart';
import 'package:journal/data/sources/remote/lessons_source.dart';
import 'package:journal/data/sources/remote/points_source.dart';
import 'package:journal/data/sources/remote/users_source.dart';
import 'package:journal/domain/repositories/auth_repository.dart';
import 'package:journal/domain/repositories/lessons_repository.dart';
import 'package:journal/domain/repositories/points_repository.dart';
import 'package:journal/domain/repositories/users_repository.dart';
import 'package:journal/domain/use_cases/get_lessons_list_use_case.dart';
import 'package:journal/domain/use_cases/get_points_list_use_case.dart';
import 'package:journal/domain/use_cases/get_users_list_use_case.dart';
import 'package:journal/domain/use_cases/login_use_case.dart';
import 'package:journal/domain/use_cases/set_lesson_use_case.dart';
import 'package:journal/domain/use_cases/set_point_use_case.dart';
import 'package:journal/domain/use_cases/update_lesson_use_case.dart';

GetIt getIt = GetIt.instance;

void setUpServiceLocator() {
  getIt.registerSingleton<PreferencesSource>(PreferencesSourceImpl());
  getIt.registerSingleton<UsersSource>(UsersSourceImpl());
  getIt.registerSingleton<LessonsSource>(LessonsSourceImpl());
  getIt.registerSingleton<PointsSource>(PointsSourceImpl());
  getIt.registerSingleton<AuthSource>(AuthSourceImpl());

  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        getIt<AuthSource>(),
        getIt<PreferencesSource>(),
      ));

  getIt.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(
        getIt<UsersSource>(),
        getIt<PreferencesSource>(),
      ));

  getIt.registerLazySingleton<LessonsRepository>(() => LessonsRepositoryImpl(
        getIt<LessonsSource>(),
        getIt<PreferencesSource>(),
      ));

  getIt.registerLazySingleton<PointsRepository>(() => PointsRepositoryImpl(
        getIt<PointsSource>(),
        getIt<PreferencesSource>(),
      ));

  getIt.registerLazySingleton<GetLessonsListUseCase>(
      () => GetLessonsListUseCase(getIt<LessonsRepository>()));

  getIt.registerLazySingleton<GetPointsListUseCase>(
          () => GetPointsListUseCase(getIt<PointsRepository>()));

  getIt.registerLazySingleton<GetUsersListUseCase>(
          () => GetUsersListUseCase(getIt<UsersRepository>()));

  getIt.registerLazySingleton<LoginUseCase>(
          () => LoginUseCase(getIt<AuthRepository>()));

  getIt.registerLazySingleton<SetLessonUseCase>(
          () => SetLessonUseCase(getIt<LessonsRepository>()));

  getIt.registerLazySingleton<SetPointUseCase>(
          () => SetPointUseCase(getIt<PointsRepository>()));

  getIt.registerLazySingleton<UpdateLessonUseCase>(
          () => UpdateLessonUseCase(getIt<LessonsRepository>()));
}
