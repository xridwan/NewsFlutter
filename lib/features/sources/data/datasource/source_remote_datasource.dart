import 'package:news_app/core/common/constants.dart';
import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/network/dio_client.dart';
import 'package:news_app/features/sources/data/dto/source_dto.dart';

class SourceRemoteDatasource {
  final DioClient _dioClient;

  const SourceRemoteDatasource(this._dioClient);

  Future<Result<List<SourceDto>, Failure>> getSources() async {
    final result = await _dioClient.get(
      Constants.sources,
      queryParam: {'apiKey': Constants.apiKey},
    );

    return result.fold(
        (failure) => FailureResult(failure),
        (response) {
          try {
            if (response.statusCode == 200){
              final data = response.data['sources'] as List;
              return SuccessResult(data.map((e) => SourceDto.fromJson(e)).toList());
            } else {
              return FailureResult(ServerFailure('Failed to load sources'));
            }
          } catch (e) {
            return FailureResult(ServerFailure(e.toString()));
          }
        }
    );
  }
}
