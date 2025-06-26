import 'package:news_app/features/articles/domain/model/article.dart';
import 'package:news_app/features/bookmark/domain/model/bookmark.dart';
import 'package:news_app/features/sources/domain/model/source.dart';

class Utils {
  static const sourceId = 'abc-news';

  static const dummyArticles = [
    Article(
      sourceId: sourceId,
      author: 'John Doe',
      title: 'Test Article',
      description: 'This is a test article',
      publishedAt: '2022-01-01',
      urlToImage: 'https://example.com/image.jpg',
    ),
  ];

  static const sources = [
    Source(id: "1", name: "News 1", description: "News description"),
    Source(id: "2", name: "News 2", description: "News description 2"),
  ];

  static const bookmarks = [
    Bookmark(
      title: "Test Article",
      description: "This is a test article",
      urlToImage: "https://example.com/image.jpg",
      publishedAt: "2022-01-01",
      sourceId: sourceId,
      author: "John Doe",
    ),
  ];

  static const bookmark = Bookmark(
    title: "Test Article",
    description: "This is a test article",
    urlToImage: "https://example.com/image.jpg",
    publishedAt: "2022-01-01",
    sourceId: sourceId,
    author: "John Doe",
  );
}
