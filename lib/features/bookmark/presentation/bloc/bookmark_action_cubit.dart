import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/bookmark/presentation/bloc/bookmark_state.dart';

import '../../domain/model/bookmark.dart';
import '../../domain/usecase/get_bookmarks_usecase.dart';

class BookmarkActionCubit extends Cubit<BookmarkState> {
  final AddBookmarkUseCase _addBookmarkUseCase;
  final RemoveBookmarkUseCase _removeBookmarkUseCase;
  final IsBookmarkedUseCase _isBookmarkedUseCase;

  BookmarkActionCubit(
    this._addBookmarkUseCase,
    this._removeBookmarkUseCase,
    this._isBookmarkedUseCase,
  ) : super(const BookmarkInitial());

  Future<void> addBookmark(Bookmark bookmark) async {
    try {
      await _addBookmarkUseCase.call(bookmark);
      emit(const BookmarkChecked(true));
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }

  Future<void> removeBookmark(String title) async {
    try {
      await _removeBookmarkUseCase.call(title);
      emit(const BookmarkChecked(false));
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }

  Future<void> isBookmarked(String title) async {
    try {
      final isBookmarked = await _isBookmarkedUseCase.call(title);
      emit(BookmarkChecked(isBookmarked));
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }
}
