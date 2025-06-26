import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/core/common/constants.dart';
import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/mapper/data_mapper.dart';
import 'package:news_app/features/sources/data/dto/source_dto.dart';
import 'package:news_app/features/sources/data/repository/source_repository_impl.dart';
import 'package:news_app/features/sources/domain/repository/source_repository.dart';

import '../../data/datasource/local/fake_local_datasource.dart';
import '../../data/datasource/remote/fake_remote_datasource.dart';

void main() {
  late SourceRepository sourceRepository;
  late FakeSourceRemoteDatasource fakeRemoteDatasource;
  late FakeSourceLocalDatasource fakeLocalDatasource;

  setUp(() {
    fakeRemoteDatasource = FakeSourceRemoteDatasource();
    fakeLocalDatasource = FakeSourceLocalDatasource();
    sourceRepository = SourceRepositoryImpl(
      fakeRemoteDatasource,
      fakeLocalDatasource,
    );
  });

  const tSourceDto = SourceDto(
    id: 'Flutter',
    name: 'FLUTTER',
    description: 'News from Flutter',
  );
  final tSource = tSourceDto.toDomain();

  final cachedJson = [tSourceDto.toJson()];

  test('returns remote data and caches it', () async {
    fakeRemoteDatasource.setResponse(Right([tSourceDto]));
    fakeLocalDatasource.cachedSources(Constants.cacheSources, cachedJson);

    final result = await sourceRepository.getSources();

    expect(result, isA<Right>());

    result.fold((failure) => fail(failure.message), (success) {
      expect(success, [tSource]);
      print(success);
    });
  });

  test('returns cached data when remote fails', () async {
    fakeRemoteDatasource.setResponse(Left(ServerFailure('No Internet')));
    fakeLocalDatasource.cachedSources(Constants.cacheSources, cachedJson);

    final result = await sourceRepository.getSources();

    expect(result, isA<Right>());

    result.fold((failure) => fail(failure.message), (success) {
      expect(success, [tSource]);
      print(success);
    });
  });

  test('returns failure when remote fails and cache is empty', () async {
    fakeRemoteDatasource.setResponse(Left(ServerFailure('No Internet')));
    fakeLocalDatasource.cachedSources(Constants.cacheSources, []);

    final result = await sourceRepository.getSources();

    expect(result, isA<Left>());

    result.fold((failure) {
      expect(failure, isA<ServerFailure>());
      expect(failure.message, 'No Internet');
      print(failure.message);
    }, (success) => fail('should not be called'));
  });
}
