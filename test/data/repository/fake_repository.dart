import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/articles/domain/model/article.dart';
import 'package:news_app/features/articles/domain/repository/article_repository.dart';
import 'package:news_app/features/bookmark/domain/model/bookmark.dart';
import 'package:news_app/features/bookmark/domain/repository/bookmark_repository.dart';
import 'package:news_app/features/sources/domain/model/source.dart';
import 'package:news_app/features/sources/domain/repository/source_repository.dart';

class FakeSourceRepository implements SourceRepository {
  Result<List<Source>, Failure>? _response;

  void setResponse(Result<List<Source>, Failure> response) {
    _response = response;
  }

  @override
  Future<Result<List<Source>, Failure>> getSources() async {
    return _response ?? Right([]);
  }
}

class FakeArticleRepository implements ArticleRepository {
  Result<List<Article>, Failure>? _response;

  void setResponse(Result<List<Article>, Failure> response) {
    _response = response;
  }

  @override
  Future<Result<List<Article>, Failure>> getArticles(String sourceId) async {
    return _response ?? Right([]);
  }
}

class FakeBookmarkRepository implements BookmarkRepository {
  final List<Bookmark> _bookmarks = [];
  bool shouldFail = false;

  void setBookmarks(List<Bookmark> bookmarks) {
    _bookmarks.clear();
    _bookmarks.addAll(bookmarks);
  }

  void setShouldFail() {
    shouldFail = true;
  }

  @override
  Future<void> addBookmark(Bookmark bookmark) async {
    if (shouldFail) {
      throw Exception('Error');
    }
    if (!_bookmarks.any((b) => b.title == bookmark.title)) {
      _bookmarks.add(bookmark);
      return Future.value();
    }
  }

  @override
  Future<List<Bookmark>> getBookmarks() async {
    if (shouldFail) {
      throw Exception('Error');
    }
    return _bookmarks;
  }

  @override
  Future<bool> isBookmarked(String title) async {
    if (shouldFail) {
      throw Exception('Error');
    }
    return _bookmarks.any((b) => b.title == title);
  }

  @override
  Future<void> removeBookmark(String title) async {
    if (shouldFail) {
      throw Exception('Error');
    }
    _bookmarks.removeWhere((b) => b.title == title);
  }
}
