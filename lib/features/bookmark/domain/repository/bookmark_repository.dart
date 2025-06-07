import 'package:news_app/features/bookmark/domain/model/bookmark.dart';

abstract class BookmarkRepository {
  Future<List<Bookmark>> getBookmarks();
  Future<void> addBookmark(Bookmark bookmark);
  Future<void> removeBookmark(String title);
  Future<bool> isBookmarked(String title);
}