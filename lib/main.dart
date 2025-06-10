import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/router/app_router.dart';
import 'package:news_app/di/app_locator.dart';
import 'package:news_app/features/settings/presentation/bloc/notification_event.dart';

import 'core/notification/notification_service.dart';
import 'features/articles/presenter/bloc/article_bloc.dart';
import 'features/bookmark/presentation/bloc/bookmark_action_cubit.dart';
import 'features/bookmark/presentation/bloc/bookmark_bloc.dart';
import 'features/settings/data/notification_preferences.dart';
import 'features/settings/presentation/bloc/notification_bloc.dart';
import 'features/sources/presentation/bloc/source_bloc.dart';
import 'features/sources/presentation/bloc/source_event.dart';
import 'features/sources/presentation/widget/bloc/search/search_visibility_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  await sl<NotificationService>().scheduleIfEnabled(
    sl<NotificationPreferences>(),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SourceBloc>()..add(GetSources())),
        BlocProvider(create: (context) => sl<ArticleBloc>()),
        BlocProvider(create: (context) => sl<BookmarkBloc>()),
        BlocProvider(create: (context) => sl<BookmarkActionCubit>()),
        BlocProvider(create: (context) => sl<SearchVisibilyBloc>()),
        BlocProvider(
          create: (context) =>
              sl<NotificationBloc>()..add(IsNotificationChecked()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Source App',
      routerConfig: router,
    );
  }
}
