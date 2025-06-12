import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/network/dio_client.dart';

import '../../../../core/common/constants.dart';
import '../dto/article_dto.dart';

class ArticleRemoteDatasource {
  final DioClient _dioClient;

  ArticleRemoteDatasource(this._dioClient);

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
