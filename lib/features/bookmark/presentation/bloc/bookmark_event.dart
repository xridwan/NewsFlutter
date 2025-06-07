import 'package:news_app/features/bookmark/domain/model/bookmark.dart';

sealed class BookmarkEvent {
  const BookmarkEvent();
}

final class GetBookmarks extends BookmarkEvent {
  const GetBookmarks();
}

final class IsBookmarked extends BookmarkEvent {
  final String title;

  const IsBookmarked(this.title);
}

final class AddBookmark extends BookmarkEvent {
  final Bookmark bookmark;

  const AddBookmark(this.bookmark);
}

final class RemoveBookmark extends BookmarkEvent {
  final String title;

  const RemoveBookmark(this.title);
}
