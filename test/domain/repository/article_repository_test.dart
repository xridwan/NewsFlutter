import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/core/common/constants.dart';
import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/mapper/data_mapper.dart';
import 'package:news_app/features/articles/data/dto/article_dto.dart';
import 'package:news_app/features/articles/data/repository/article_repository_impl.dart';
import 'package:news_app/features/articles/domain/repository/article_repository.dart';

import '../../data/datasource/local/fake_local_datasource.dart';
import '../../data/datasource/remote/fake_remote_datasource.dart';

void main() {
  late ArticleRepository articleRepository;
  late FakeArticleRemoteDatasource fakeRemoteDatasource;
  late FakeArticleLocalDatasource fakeLocalDatasource;

  setUp(() {
    fakeRemoteDatasource = FakeArticleRemoteDatasource();
    fakeLocalDatasource = FakeArticleLocalDatasource();
    articleRepository = ArticleRepositoryImpl(
      fakeRemoteDatasource,
      fakeLocalDatasource,
    );
  });

  const sourceId = 'abc-news';

  const tArticleDto = ArticleDto(
    sourceId: sourceId,
    author: 'FLUTTER',
    title: 'News from Flutter',
    description: 'News from Flutter',
    publishedAt: 'News from Flutter',
    urlToImage: 'News from Flutter',
  );

  final tArticle = tArticleDto.toDomain(sourceId);

  final cachedJson = [tArticleDto.toJson()];

  group('get articles data', () {
    test('returns remote data and caches it', () async {
      fakeRemoteDatasource.setResponse(Right([tArticleDto]));
      fakeLocalDatasource.cachedArticles(Constants.cacheArticles, cachedJson);

      final result = await articleRepository.getArticles(sourceId);

      expect(result, isA<Right>());

      result.fold(
        (failure) => fail(failure.message),
        (success) => expect(success, [tArticle]),
      );
    });

    test('returns cached data when remote fails', () async {
      fakeRemoteDatasource.setResponse(Left(ServerFailure('No Internet')));
      fakeLocalDatasource.cachedArticles(Constants.cacheArticles, cachedJson);

      final result = await articleRepository.getArticles(sourceId);

      expect(result, isA<Right>());

      result.fold(
        (failure) => fail(failure.message),
        (success) => expect(success, [tArticle]),
      );
    });

    test('returns failure when remote fails and cache is empty', () async {
      fakeRemoteDatasource.setResponse(Left(ServerFailure('No Internet')));
      fakeLocalDatasource.cachedArticles(Constants.cacheArticles, []);

      final result = await articleRepository.getArticles(sourceId);

      expect(result, isA<Left>());

      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (success) => fail('should not be called'),
      );
    });
  });
}
