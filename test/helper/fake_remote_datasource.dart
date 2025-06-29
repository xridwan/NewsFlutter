import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/articles/data/datasource/article_remote_datasource.dart';
import 'package:news_app/features/articles/data/dto/article_dto.dart';
import 'package:news_app/features/sources/data/datasource/source_remote_datasource.dart';
import 'package:news_app/features/sources/data/dto/source_dto.dart';

class FakeSourceRemoteDatasource implements SourceRemoteDatasource {
  Result<List<SourceDto>, Failure>? _response;

  void setResponse(Result<List<SourceDto>, Failure> response) {
    _response = response;
  }

  @override
  Future<Result<List<SourceDto>, Failure>> getSources() async {
    return _response ?? Right([]);
  }
}

class FakeArticleRemoteDatasource implements ArticleRemoteDatasource {
  Result<List<ArticleDto>, Failure>? _response;

  void setResponse(Result<List<ArticleDto>, Failure> response) {
    _response = response;
  }

  @override
  Future<Result<List<ArticleDto>, Failure>> getArticles(String sourceId) async {
    return _response ?? Right([]);
  }
}
