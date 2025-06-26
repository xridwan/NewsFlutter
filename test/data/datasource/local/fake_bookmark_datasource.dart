import 'package:news_app/features/bookmark/data/datasource/bookmark_local_datasource.dart';
import 'package:news_app/features/bookmark/data/dto/bookmark_dto.dart';

class FakeBookmarkDatasource implements BookmarkLocalDatasource {
  final List<BookmarkDto> _storage = [];

  @override
  Future<void> addBookmark(BookmarkDto bookmark) async {
    _storage.add(bookmark);
  }

  @override
  Future<List<BookmarkDto>> getBookmarks() async {
    return _storage;
  }

  @override
  Future<bool> isBookmarked(String title) async {
    return _storage.any((element) => element.title == title);
  }

  @override
  Future<void> removeBookmark(String title) async {
    _storage.removeWhere((element) => element.title == title);
  }
}
