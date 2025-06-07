import 'package:news_app/core/base/base_use_case.dart';
import 'package:news_app/features/bookmark/domain/model/bookmark.dart';

import '../repository/bookmark_repository.dart';

class GetBookmarksUseCase extends BaseUseCase<List<Bookmark>, NoParams> {
  final BookmarkRepository _repository;

  GetBookmarksUseCase(this._repository);

  @override
  Future<List<Bookmark>> call(NoParams params) async {
    return _repository.getBookmarks();
  }
}

class RemoveBookmarkUseCase extends BaseUseCase<void, String> {
  final BookmarkRepository _repository;

  RemoveBookmarkUseCase(this._repository);

  @override
  Future<void> call(String params) async {
    await _repository.removeBookmark(params);
  }
}

class AddBookmarkUseCase extends BaseUseCase<void, Bookmark> {
  final BookmarkRepository _repository;

  AddBookmarkUseCase(this._repository);

  @override
  Future<void> call(Bookmark params) async {
    await _repository.addBookmark(params);
  }
}

class IsBookmarkedUseCase extends BaseUseCase<bool, String> {
  final BookmarkRepository _repository;

  IsBookmarkedUseCase(this._repository);

  @override
  Future<bool> call(String params) async {
    final result = await _repository.isBookmarked(params);
    return result;
  }
}
