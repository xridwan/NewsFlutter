import 'package:news_app/core/common/constants.dart';
import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/network/dio_client.dart';
import 'package:news_app/features/sources/data/dto/source_dto.dart';

abstract class SourceRemoteDatasource {
  const SourceRemoteDatasource();

  Future<Result<List<SourceDto>, Failure>> getSources();
}

class SourceRemoteDatasourceImpl implements SourceRemoteDatasource {
  final DioClient _dioClient;

  const SourceRemoteDatasourceImpl(this._dioClient);

  @override
  Future<Result<List<SourceDto>, Failure>> getSources() async {
    final result = await _dioClient.get(
      Constants.sources,
      queryParam: {'apiKey': Constants.apiKey},
    );

    return result.fold(
        (failure) => Left(failure),
        (response) {
          try {
            if (response.statusCode == 200){
              final data = response.data['sources'] as List;
              return Right(data.map((e) => SourceDto.fromJson(e)).toList());
            } else {
              return Left(ServerFailure('Failed to load sources'));
            }
          } catch (e) {
            return Left(ServerFailure(e.toString()));
          }
        }
    );
  }
}
