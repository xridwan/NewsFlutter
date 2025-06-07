import '../../domain/model/article.dart';

sealed class ArticleState {
  const ArticleState();
}

final class ArticleInitial extends ArticleState {
  const ArticleInitial();
}

final class ArticleLoading extends ArticleState {
  const ArticleLoading();
}

final class ArticleLoaded extends ArticleState {
  final List<Article> articles;

  const ArticleLoaded(this.articles);
}

final class ArticleError extends ArticleState {
  final String message;

  const ArticleError(this.message);
}
