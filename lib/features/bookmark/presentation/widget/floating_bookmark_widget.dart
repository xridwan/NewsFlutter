import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/bookmark/domain/model/bookmark.dart';
import 'package:news_app/features/bookmark/presentation/bloc/bookmark_bloc.dart';

import '../bloc/bookmark_event.dart';
import '../bloc/bookmark_state.dart';

class FloatingBookmarkWidget extends StatelessWidget {
  final Bookmark bookmark;

  const FloatingBookmarkWidget({super.key, required this.bookmark});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookmarkBloc>().add(IsBookmarked(bookmark.title));
    });
    return BlocSelector<BookmarkBloc, BookmarkState, bool>(
      selector: (state) {
        if (state is BookmarkChecked) {
          return state.isBookmarked;
        }
        return false;
      },
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: () {
            if (state) {
              context.read<BookmarkBloc>().add(RemoveBookmark(bookmark.title));
            } else {
              context.read<BookmarkBloc>().add(AddBookmark(bookmark));
            }
          },
          backgroundColor: Colors.grey[800],
          child: Icon(
            state ? Icons.bookmark : Icons.bookmark_border,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
