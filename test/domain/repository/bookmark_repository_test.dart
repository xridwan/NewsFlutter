import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/features/bookmark/data/repository/bookmark_repository_impl.dart';
import 'package:news_app/features/bookmark/domain/repository/bookmark_repository.dart';

import '../../common/Utils.dart';
import '../../data/datasource/local/fake_bookmark_datasource.dart';

void main() {
  late FakeBookmarkDatasource fakeBookmarkDatasource;
  late BookmarkRepository bookmarkRepository;

  setUp(() {
    fakeBookmarkDatasource = FakeBookmarkDatasource();
    bookmarkRepository = BookmarkRepositoryImpl(fakeBookmarkDatasource);
  });

  test('should add and get bookmarks', () async {
    final bookmark1 = Utils.bookmark;

    await bookmarkRepository.addBookmark(bookmark1);
    final bookmarks = await bookmarkRepository.getBookmarks();

    expect(bookmarks, [bookmark1]);
    expect(bookmarks.length, 1);
  });

  test('should remove bookmark', () async {
    final bookmark1 = Utils.bookmark;

    await bookmarkRepository.addBookmark(bookmark1);
    await bookmarkRepository.removeBookmark(bookmark1.title);
    final bookmarks = await bookmarkRepository.getBookmarks();

    expect(bookmarks, []);
    expect(bookmarks.length, 0);
  });

  test('should check if bookmark exists', () async {
    final bookmark1 = Utils.bookmark;

    await bookmarkRepository.addBookmark(bookmark1);
    final exists = await bookmarkRepository.isBookmarked(bookmark1.title);

    expect(exists, true);

    await bookmarkRepository.removeBookmark(bookmark1.title);
    final notExists = await bookmarkRepository.isBookmarked(bookmark1.title);

    expect(notExists, false);
  });
}
