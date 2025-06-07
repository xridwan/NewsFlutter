import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_use_case.dart';
import '../../domain/usecase/get_bookmarks_usecase.dart';
import 'bookmark_event.dart';
import 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final GetBookmarksUseCase _getBookmarksUseCase;
  final AddBookmarkUseCase _addBookmarkUseCase;
  final RemoveBookmarkUseCase _removeBookmarkUseCase;
  final IsBookmarkedUseCase _isBookmarkedUseCase;

  BookmarkBloc(
    this._getBookmarksUseCase,
    this._addBookmarkUseCase,
    this._removeBookmarkUseCase,
    this._isBookmarkedUseCase,
  ) : super(const BookmarkInitial()) {
    on<GetBookmarks>((event, emit) async {
      emit(const BookmarkLoading());
      try {
        final bookmarks = await _getBookmarksUseCase.call(NoParams());
        emit(BookmarkLoaded(bookmarks));
      } catch (e) {
        emit(BookmarkError(e.toString()));
      }
    });

    on<AddBookmark>((event, emit) async {
      try {
        await _addBookmarkUseCase.call(event.bookmark);
        emit(const BookmarkChecked(true));
      } catch (e) {
        emit(BookmarkError(e.toString()));
      }
    });

    on<RemoveBookmark>((event, emit) async {
      try {
        await _removeBookmarkUseCase.call(event.title);
        emit(const BookmarkChecked(false));
      } catch (e) {
        emit(BookmarkError(e.toString()));
      }
    });

    on<IsBookmarked>((event, emit) async {
      try {
        final isBookmarked = await _isBookmarkedUseCase.call(event.title);
        emit(BookmarkChecked(isBookmarked));
      } catch (e) {
        emit(BookmarkError(e.toString()));
      }
    });
  }
}
