import 'package:news_app/core/mapper/data_mapper.dart';
import 'package:news_app/features/bookmark/data/datasource/bookmark_local_datasource.dart';
import 'package:news_app/features/bookmark/domain/repository/bookmark_repository.dart';

import '../../domain/model/bookmark.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkLocalDatasource _localDatasource;

  const BookmarkRepositoryImpl(this._localDatasource);

  @override
  Future<List<Bookmark>> getBookmarks() async {
    final result = await _localDatasource.getBookmarks();
    return result.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> addBookmark(Bookmark bookmark) async {
    await _localDatasource.addBookmark(bookmark.toDto());
  }

  @override
  Future<void> removeBookmark(String title) async {
    await _localDatasource.removeBookmark(title);
  }

  @override
  Future<bool> isBookmarked(String title) async {
    final result = await _localDatasource.isBookmarked(title);
    return result;
  }
}
