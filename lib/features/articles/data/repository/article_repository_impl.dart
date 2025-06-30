import 'package:news_app/core/common/constants.dart';
import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/mapper/data_mapper.dart';
import 'package:news_app/features/articles/data/dto/article_dto.dart';
import 'package:news_app/features/articles/domain/repository/article_repository.dart';

import '../../domain/model/article.dart';
import '../datasource/article_local_datasource.dart';
import '../datasource/article_remote_datasource.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDatasource _articleRemoteDatasource;
  final ArticleLocalDatasource _articleLocalDatasource;

  const ArticleRepositoryImpl(
    this._articleRemoteDatasource,
    this._articleLocalDatasource,
  );

  @override
  Future<Result<List<Article>, Failure>> getArticles(String sourceId) async {
    final result = await _articleRemoteDatasource.getArticles(sourceId);
    return result.fold(
      (failure) async {
        final cachedArticles = await _articleLocalDatasource.getCachedArticles(
          Constants.cacheArticles,
        );
        if (cachedArticles.isNotEmpty) {
          final articles =
              cachedArticles.map((e) => ArticleDto.fromJson(e)).toList();
          return Right(articles);
        } else {
          return Left(failure);
        }
      },
      (response) async {
        final jsonList = response.map((e) => e.toJson()).toList();
        await _articleLocalDatasource.cachedArticles(Constants.cacheArticles, jsonList);
        return Right(response.map((e) => e.toDomain(sourceId)).toList());
      },
    );
  }
}
