import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/mapper/data_mapper.dart';
import 'package:news_app/core/widget/empty_data_widget.dart';
import 'package:news_app/core/widget/loading_widget.dart';
import 'package:news_app/features/bookmark/presentation/bloc/bookmark_event.dart';
import 'package:news_app/features/bookmark/presentation/widget/app_bar_widget.dart';
import 'package:news_app/features/bookmark/presentation/widget/bookmark_item_widget.dart';

import '../../../../core/router/navigation_route.dart';
import '../bloc/bookmark_bloc.dart';
import '../bloc/bookmark_state.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BookmarkBloc>().add(GetBookmarks());
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            navigateBack: () {
              context.pop(context);
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<BookmarkBloc>().add(GetBookmarks());
              },
              child: BlocBuilder<BookmarkBloc, BookmarkState>(
                builder: (context, state) {
                  if (state is BookmarkLoading) {
                    return LoadingWidget();
                  } else if (state is BookmarkLoaded) {
                    if (state.bookmarks.isEmpty) {
                      return EmptyDataWidget(message: 'Data is Empty');
                    } else {
                      return ListView.builder(
                        itemCount: state.bookmarks.length,
                        itemBuilder: (context, index) {
                          final bookmark = state.bookmarks[index];
                          return BookmarkItemWidget(
                            bookmark: bookmark,
                            navigateToDetail: () async {
                              final result = await context.push(
                                NavigationRoute.detailPage,
                                extra: bookmark.toArticle(),
                              );

                              if (result == true && context.mounted) {
                                context.read<BookmarkBloc>().add(
                                  GetBookmarks(),
                                );
                              }
                            },
                          );
                        },
                      );
                    }
                  } else if (state is BookmarkError) {
                    return EmptyDataWidget(message: state.message);
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
