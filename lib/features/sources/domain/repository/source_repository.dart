import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/sources/domain/model/source.dart';

abstract class SourceRepository {
  Future<Result<List<Source>, Failure>> getSources();
}
