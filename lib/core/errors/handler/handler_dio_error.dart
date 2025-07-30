import 'package:dio/dio.dart';

import '../failure.dart';

Failure handleDioError(DioException e) {
  if (e.response != null) {
    final statusCode = e.response?.statusCode ?? 0;
    final statusMessage = e.response?.statusMessage ?? "Unknown error";

    switch (statusCode) {
      case 400:
        return ServerFailure(statusMessage);
      case 401:
        return ServerFailure(statusMessage);
      case 429:
        return ServerFailure(statusMessage);
      case 500:
        return ServerFailure(statusMessage);
      default:
        return ServerFailure(statusMessage);
    }
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return NetworkFailure(
        "Connection timeout - Check your internet connection",
      );
    case DioExceptionType.sendTimeout:
      return NetworkFailure("Send timeout - Request time out");
    case DioExceptionType.receiveTimeout:
      return NetworkFailure("Receive timeout - Response time out");
    case DioExceptionType.badCertificate:
      return NetworkFailure("Invalid SSL Certificate");
    case DioExceptionType.badResponse:
      return ServerFailure("Bad response - Data Invalid");
    case DioExceptionType.cancel:
      return NetworkFailure("Request canceled");
    case DioExceptionType.connectionError:
      return NetworkFailure("No internet connection");
    case DioExceptionType.unknown:
      return NetworkFailure("Unknown error: ${e.message}");
  }
}
