import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/database/database_helper.dart';
import 'package:news_app/core/notification/notification_service.dart';
import 'package:news_app/features/articles/data/datasource/article_remote_datasource.dart';
import 'package:news_app/features/articles/domain/repository/article_repository.dart';
import 'package:news_app/features/articles/domain/usecase/get_article_usecase.dart';
import 'package:news_app/features/bookmark/data/datasource/bookmark_local_datasource.dart';
import 'package:news_app/features/bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:news_app/features/sources/data/datasource/source_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/network/dio_client.dart';
import '../features/articles/data/datasource/article_local_datasource.dart';
import '../features/articles/data/repository/article_repository_impl.dart';
import '../features/articles/presenter/bloc/article_bloc.dart';
import '../features/bookmark/data/repository/bookmark_repository_impl.dart';
import '../features/bookmark/domain/repository/bookmark_repository.dart';
import '../features/bookmark/domain/usecase/get_bookmarks_usecase.dart';
import '../features/bookmark/presentation/bloc/bookmark_action_cubit.dart';
import '../features/settings/data/notification_preferences.dart';
import '../features/settings/presentation/bloc/notification_bloc.dart';
import '../features/sources/data/datasource/source_remote_datasource.dart';
import '../features/sources/data/repository/source_repository_impl.dart';
import '../features/sources/domain/repository/source_repository.dart';
import '../features/sources/domain/usecase/get_source_usecase.dart';
import '../features/sources/presentation/bloc/source_bloc.dart';
import '../features/sources/presentation/widget/bloc/search/search_visibility_bloc.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Notification
  sl.registerLazySingleton(() => NotificationService());
  await sl<NotificationService>().initialized();

  // Shared Preferences Setup
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => NotificationPreferences(sl()));

  // Database Setup
  final dbHelper = DatabaseHelper();
  await dbHelper.database;
  sl.registerLazySingleton(() => dbHelper);

  // Dio Setup
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton(() => DioClient());

  // Local Datasource
  sl.registerLazySingleton<SourceLocalDataSource>(
    () => SourceLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ArticleLocalDatasource>(
    () => ArticleLocalDatasourceImpl(sl()),
  );

  // Remote Datasource
  sl.registerLazySingleton<SourceRemoteDatasource>(
    () => SourceRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<ArticleRemoteDatasource>(
    () => ArticleRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<BookmarkLocalDatasource>(
    () => BookmarkLocalDatasourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<SourceRepository>(
    () => SourceRepositoryImpl(
      sl<SourceRemoteDatasource>(),
      sl<SourceLocalDataSource>(),
    ),
  );
  sl.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(
      sl<ArticleRemoteDatasource>(),
      sl<ArticleLocalDatasource>(),
    ),
  );
  sl.registerLazySingleton<BookmarkRepository>(
    () => BookmarkRepositoryImpl(sl()),
  );

  // UseCase
  sl.registerFactory(() => GetSourceUseCase(sl()));
  sl.registerFactory(() => GetArticleUseCase(sl()));
  sl.registerFactory(() => GetBookmarksUseCase(sl()));
  sl.registerFactory(() => RemoveBookmarkUseCase(sl()));
  sl.registerFactory(() => AddBookmarkUseCase(sl()));
  sl.registerFactory(() => IsBookmarkedUseCase(sl()));

  // Bloc
  sl.registerFactory(() => SourceBloc(sl()));
  sl.registerFactory(() => ArticleBloc(sl()));
  sl.registerFactory(() => BookmarkBloc(sl()));
  sl.registerFactory(() => BookmarkActionCubit(sl(), sl(), sl()));
  sl.registerFactory(() => SearchVisibilyBloc());
  sl.registerFactory(() => NotificationBloc(sl(), sl()));
}
