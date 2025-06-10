import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/bookmark/domain/model/bookmark.dart';
import 'package:news_app/features/bookmark/presentation/bloc/bookmark_action_cubit.dart';

import '../bloc/bookmark_state.dart';

class FloatingBookmarkWidget extends StatelessWidget {
  final Bookmark bookmark;

  const FloatingBookmarkWidget({super.key, required this.bookmark});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookmarkActionCubit>().isBookmarked(bookmark.title);
    });
    return BlocBuilder<BookmarkActionCubit, BookmarkState>(
      builder: (context, state) {
        bool isBookmark = false;
        if (state is BookmarkChecked) {
          isBookmark = state.isBookmarked;
        }
        return FloatingActionButton(
          onPressed: () {
            if (!isBookmark) {
              context.read<BookmarkActionCubit>().addBookmark(bookmark);
            } else {
              context.read<BookmarkActionCubit>().removeBookmark(
                bookmark.title,
              );
            }
          },
          backgroundColor: Colors.grey[800],
          child: Icon(
            isBookmark ? Icons.bookmark : Icons.bookmark_border,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
