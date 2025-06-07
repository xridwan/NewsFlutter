import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/articles/domain/model/article.dart';

abstract class ArticleRepository {
  Future<Result<List<Article>, Failure>> getArticles(String sourceId);
}
