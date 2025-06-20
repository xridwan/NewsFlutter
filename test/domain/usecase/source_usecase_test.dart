import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/core/base/base_use_case.dart';
import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/sources/domain/usecase/get_source_usecase.dart';

import '../../common/Utils.dart';
import '../../data/repository/fake_repository.dart';

void main() {
  late FakeSourceRepository fakeRepository;
  late GetSourceUseCase getSourceUseCase;

  setUp(() {
    fakeRepository = FakeSourceRepository();
    getSourceUseCase = GetSourceUseCase(fakeRepository);
  });

  test('should return list of sources when repository returns Right', () async {
    fakeRepository.setResponse(Right(Utils.sources));

    final result = await getSourceUseCase(NoParams());

    expect(result, isA<Right>());

    result.fold(
      (failure) => fail("Expected success but got failure"),
      (success) => expect(success, equals(Utils.sources)),
    );
  });

  test(
    'should return ServerFailure when repository returns ServerFailure',
    () async {
      const failure = ServerFailure('Failed to load sources');

      fakeRepository.setResponse(Left(failure));

      final result = await getSourceUseCase(NoParams());

      expect(result, isA<Left>());

      result.fold((failure) {
        expect(failure, equals(failure));
        expect(failure.message, equals('Failed to load sources'));
      }, (success) => fail("Expected failure but got success"));
    },
  );

  test(
    'should return NetworkFailure when repository returns NetworkFailure',
    () async {
      const failure = NetworkFailure('No internet connection');

      fakeRepository.setResponse(Left(failure));

      final result = await getSourceUseCase(NoParams());

      expect(result, isA<Left>());

      result.fold((failure) {
        expect(failure, equals(failure));
        expect(failure.message, equals('No internet connection'));
      }, (success) => fail("Expected failure but got success"));
    },
  );

  test(
    'should return LocalFailure when repository returns LocalFailure',
    () async {
      const failure = LocalFailure('Failed to load sources');

      fakeRepository.setResponse(Left(failure));

      final result = await getSourceUseCase(NoParams());

      expect(result, isA<Left>());

      result.fold((failure) {
        expect(failure, equals(failure));
        expect(failure.message, equals('Failed to load sources'));
      }, (success) => fail("Expected failure but got success"));
    },
  );
}
