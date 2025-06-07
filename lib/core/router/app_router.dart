import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/router/navigation_route.dart';
import 'package:news_app/features/articles/domain/model/article.dart';
import 'package:news_app/features/articles/presenter/page/article_page.dart';
import 'package:news_app/features/bookmark/presentation/page/bookmark_page.dart';
import 'package:news_app/features/bookmark/presentation/page/detail_page.dart';
import 'package:news_app/features/settings/presentation/page/settings_page.dart';
import 'package:news_app/features/sources/presentation/page/source_page.dart';

final GoRouter router = GoRouter(
  initialLocation: NavigationRoute.sourcePage,
  routes: [
    GoRoute(
      name: 'sourcePage',
      path: NavigationRoute.sourcePage,
      builder: (context, state) => const SourcePage(),
    ),
    GoRoute(
      name: 'bookmarkPage',
      path: NavigationRoute.bookmarkPage,
      builder: (context, state) => const BookmarkPage(),
    ),
    GoRoute(
      name: 'detailPage',
      path: NavigationRoute.detailPage,
      builder: (context, state) {
        final extra = state.extra as Article;
        return DetailPage(article: extra);
      },
    ),
    GoRoute(
      name: 'settingsPage',
      path: NavigationRoute.settingsPage,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      name: 'articlePage',
      path: NavigationRoute.articlePage,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return ArticlePage(
          id: extra['id'],
          name: extra['name'],
          description: extra['desc'],
        );
      },
    ),
  ],
);
