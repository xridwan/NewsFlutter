import 'package:dio/dio.dart';
import 'package:news_app/core/common/constants.dart';
import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/errors/handler/handler_dio_error.dart';

class DioClient {
  final Dio _dio;

  DioClient() : _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl));

  Future<Result<Response, Failure>> get(
    String path, {
    Map<String, dynamic>? queryParam,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParam);
      return Right(response);
    } on DioException catch (e) {
      return Left(handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
