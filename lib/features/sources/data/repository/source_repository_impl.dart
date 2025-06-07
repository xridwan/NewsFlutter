import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/mapper/data_mapper.dart';
import 'package:news_app/features/sources/data/datasource/source_local_datasource.dart';
import 'package:news_app/features/sources/data/datasource/source_remote_datasource.dart';
import 'package:news_app/features/sources/domain/model/source.dart';
import 'package:news_app/features/sources/domain/repository/source_repository.dart';

import '../../../../core/common/constants.dart';
import '../dto/source_dto.dart';

class SourceRepositoryImpl implements SourceRepository {
  final SourceRemoteDatasource _remoteDatasource;
  final SourceLocalDataSource _localDataSource;

  const SourceRepositoryImpl(this._remoteDatasource, this._localDataSource);

  @override
  Future<Result<List<Source>, Failure>> getSources() async {
    final result = await _remoteDatasource.getSources();
    return result.fold(
      (failure) async {
        final cachedSources = await _localDataSource.getCachedSources(
          Constants.cacheSources,
        );
        if (cachedSources.isNotEmpty) {
          final sources =
              cachedSources
                  .map((e) => SourceDto.fromJson(e).toDomain())
                  .toList();
          return SuccessResult(sources);
        } else {
          return FailureResult(failure);
        }
      },
      (response) async {
        final jsonList = response.map((e) => e.toJson()).toList();
        await _localDataSource.cachedSources(Constants.cacheSources, jsonList);
        return SuccessResult(response.map((e) => e.toDomain()).toList());
      },
    );
  }
}
