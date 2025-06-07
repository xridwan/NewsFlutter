import 'package:news_app/core/base/base_use_case.dart';
import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/sources/domain/model/source.dart';
import 'package:news_app/features/sources/domain/repository/source_repository.dart';

class GetSourceUseCase
    extends BaseUseCase<Result<List<Source>, Failure>, NoParams> {
  final SourceRepository _repository;

  GetSourceUseCase(this._repository);

  @override
  Future<Result<List<Source>, Failure>> call(NoParams params) async {
    return _repository.getSources();
  }
}
