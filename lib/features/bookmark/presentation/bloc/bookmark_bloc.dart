import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_use_case.dart';
import '../../domain/usecase/get_bookmarks_usecase.dart';
import 'bookmark_event.dart';
import 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final GetBookmarksUseCase _getBookmarksUseCase;

  BookmarkBloc(this._getBookmarksUseCase) : super(const BookmarkInitial()) {
    on<GetBookmarks>((event, emit) async {
      emit(const BookmarkLoading());
      try {
        final bookmarks = await _getBookmarksUseCase.call(NoParams());
        emit(BookmarkLoaded(bookmarks));
      } catch (e) {
        emit(BookmarkError(e.toString()));
      }
    });
  }
}
