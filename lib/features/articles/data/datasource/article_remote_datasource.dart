import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/network/dio_client.dart';

import '../../../../core/common/constants.dart';
import '../dto/article_dto.dart';

abstract class ArticleRemoteDatasource {
  const ArticleRemoteDatasource();

  Future<Result<List<ArticleDto>, Failure>> getArticles(String sourceId);
}

class ArticleRemoteDatasourceImpl implements ArticleRemoteDatasource {
  final DioClient _dioClient;

  ArticleRemoteDatasourceImpl(this._dioClient);

  @override
  Future<Result<List<ArticleDto>, Failure>> getArticles(String sourceId) async {
    final result = await _dioClient.get(
      Constants.topHeadline,
      queryParam: {'sources': sourceId, 'apiKey': Constants.apiKey},
    );

    return result.fold(
      (failure) => Left(failure),
      (response) {
        try {
          if (response.statusCode == 200) {
            final data = response.data['articles'] as List;
            return Right(data.map((e) => ArticleDto.fromJson(e)).toList());
          } else {
            return Left(ServerFailure('Failed to load articles'));
          }
        } catch (e) {
          return Left(ServerFailure(e.toString()));
        }
      }
    );
  }
}
