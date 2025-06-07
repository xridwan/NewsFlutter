import 'package:news_app/core/base/base_use_case.dart';
import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/articles/domain/repository/article_repository.dart';

import '../model/article.dart';

class GetArticleUseCase
    extends BaseUseCase<Result<List<Article>, Failure>, String> {
  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);

  @override
  Future<Result<List<Article>, Failure>> call(String params) async {
    return _articleRepository.getArticles(params);
  }
}
