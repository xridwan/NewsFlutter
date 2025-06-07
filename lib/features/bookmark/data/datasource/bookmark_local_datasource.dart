import 'package:news_app/core/database/database_helper.dart';
import 'package:news_app/features/bookmark/data/dto/bookmark_dto.dart';

class BookmarkLocalDatasource {
  final DatabaseHelper _helper;

  const BookmarkLocalDatasource(this._helper);

  Future<List<BookmarkDto>> getBookmarks() async {
    final db = await _helper.database;
    final List<Map<String, dynamic>> result = await db.query(_helper.tableName);
    return result.map((e) => BookmarkDto.fromJson(e)).toList();
  }

  Future<void> addBookmark(BookmarkDto bookmark) async {
    final db = await _helper.database;
    await db.insert(_helper.tableName, bookmark.toJson());
  }

  Future<void> removeBookmark(String title) async {
    final db = await _helper.database;
    await db.delete(_helper.tableName, where: 'title = ?', whereArgs: [title]);
  }

  Future<bool> isBookmarked(String title) async {
    final db = await _helper.database;
    final List<Map<String, dynamic>> result = await db.query(
      _helper.tableName,
      where: "title = ?",
      whereArgs: [title],
    );
    return result.isNotEmpty;
  }
}
