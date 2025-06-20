import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/core/common/result.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/articles/domain/usecase/get_article_usecase.dart';

import '../../common/Utils.dart';
import '../../data/repository/fake_repository.dart';

void main() {
  late FakeArticleRepository fakeRepository;
  late GetArticleUseCase getArticleUseCase;

  setUp(() {
    fakeRepository = FakeArticleRepository();
    getArticleUseCase = GetArticleUseCase(fakeRepository);
  });

  test('should return list of articles when repository returns Right', () async {
    fakeRepository.setResponse(Right(Utils.dummyArticles));

    final result = await getArticleUseCase(Utils.sourceId);

    expect(result, isA<Right>());
    result.fold(
      (failure) => fail('Expected success but got failure'),
      (success) => expect(success, equals(Utils.dummyArticles)),
    );
  });

  test('should return a failure when repository throws an exception', () async {
    const failure = ServerFailure('Failed to load articles');

    fakeRepository.setResponse(Left(failure));

    final result = await getArticleUseCase(Utils.sourceId);

    expect(result, isA<Left>());

    result.fold((failure) {
      expect(failure, equals(failure));
      expect(failure.message, equals('Failed to load articles'));
    }, (success) => fail('Expected failure but got success'));
  });

  test('should return a failure when repository throws an exception', () async {
    const failure = NetworkFailure('Failed to load articles');

    fakeRepository.setResponse(Left(failure));

    final result = await getArticleUseCase(Utils.sourceId);

    result.fold((failure) {
      expect(failure, equals(failure));
      expect(failure.message, equals('Failed to load articles'));
    }, (success) => fail('Expected failure but got success'));
  });

  test('should return a failure when repository throws an exception', () async {
    const failure = LocalFailure('Failed to load articles');

    fakeRepository.setResponse(Left(failure));

    final result = await getArticleUseCase(Utils.sourceId);

    result.fold((failure) {
      expect(failure, equals(failure));
      expect(failure.message, equals('Failed to load articles'));
    }, (success) => fail('Expected failure but got success'));
  });
}
