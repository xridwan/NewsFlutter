sealed class ArticleEvent {
  const ArticleEvent();
}

final class GetArticles extends ArticleEvent {
  final String sourceId;

  const GetArticles(this.sourceId);
}
