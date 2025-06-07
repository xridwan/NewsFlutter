import '../../domain/model/bookmark.dart';

sealed class BookmarkState {
  const BookmarkState();
}

final class BookmarkInitial extends BookmarkState {
  const BookmarkInitial();
}

final class BookmarkLoading extends BookmarkState {
  const BookmarkLoading();
}

final class BookmarkLoaded extends BookmarkState {
  final List<Bookmark> bookmarks;

  const BookmarkLoaded(this.bookmarks);
}

final class BookmarkChecked extends BookmarkState {
  final bool isBookmarked;

  const BookmarkChecked(this.isBookmarked);
}

final class BookmarkError extends BookmarkState {
  final String message;

  const BookmarkError(this.message);
}
