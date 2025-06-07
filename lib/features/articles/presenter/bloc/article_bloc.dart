import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/articles/domain/usecase/get_article_usecase.dart';

import 'article_event.dart';
import 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticleUseCase _getArticleUseCase;

  ArticleBloc(this._getArticleUseCase) : super(const ArticleInitial()) {
    on<ArticleEvent>((event, emit) async {
      switch (event) {
        case GetArticles():
          emit(const ArticleLoading());
          final result = await _getArticleUseCase(event.sourceId);
          result.fold(
            (error) => emit(ArticleError(error.message)),
            (result) => emit(ArticleLoaded(result)),
          );
          break;
      }
    });
  }
}
