import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/core/base/base_use_case.dart';
import 'package:news_app/features/bookmark/domain/model/bookmark.dart';
import 'package:news_app/features/bookmark/domain/usecase/get_bookmarks_usecase.dart';

import '../../common/Utils.dart';
import '../../helper/fake_repository.dart';

void main() {
  late FakeBookmarkRepository fakeRepository;
  late GetBookmarksUseCase getBookmarksUseCase;
  late AddBookmarkUseCase addBookmarkUseCase;

  setUp(() {
    fakeRepository = FakeBookmarkRepository();
    getBookmarksUseCase = GetBookmarksUseCase(fakeRepository);
    addBookmarkUseCase = AddBookmarkUseCase(fakeRepository);
  });

  group('get bookmark', () {
    test(
      'should return list of bookmarks when repository returns Right',
      () async {
        fakeRepository.setBookmarks(Utils.bookmarks);

        final result = await getBookmarksUseCase(NoParams());

        expect(result, isA<List<Bookmark>>());
        expect(result.length, 1);
        expect(result.first.title, Utils.bookmarks.first.title);
      },
    );

    test(
      'should throw an exception when repository throws an exception',
      () async {
        fakeRepository.setShouldFail();

        expectLater(
          () => getBookmarksUseCase(NoParams()),
          throwsA(isA<Exception>()),
        );

        expect(
          () => getBookmarksUseCase(NoParams()),
          throwsA(
            predicate((e) => e is Exception && e.toString().contains('Error')),
          ),
        );
      },
    );
  });

  group('add bookmark', () {
    test(
      'should add bookmark to repository when repository returns Right',
      () async {
        final book1 = Bookmark(
          title: "Test Article 1",
          description: "This is a test article",
          urlToImage: "https://example.com/image.jpg",
          publishedAt: "2022-01-01",
          sourceId: 'test-article',
          author: "John Doe",
        );

        fakeRepository.setBookmarks(Utils.bookmarks);

        await addBookmarkUseCase(book1);
        final bookmarks = await getBookmarksUseCase(NoParams());

        expect(bookmarks.length, 2);
      },
    );

    test(
      'should throw an exception when repository throws an exception',
      () async {
        fakeRepository.setShouldFail();

        expectLater(
          () => addBookmarkUseCase(Utils.bookmarks.first),
          throwsA(isA<Exception>()),
        );

        expect(
          () => getBookmarksUseCase(NoParams()),
          throwsA(
            predicate((e) => e is Exception && e.toString().contains('Error')),
          ),
        );
      },
    );
  });

  group('is bookmarkd', () {
    test('should return true when repository returns true', () async {
      fakeRepository.setBookmarks(Utils.bookmarks);

      final result = await IsBookmarkedUseCase(
        fakeRepository,
      ).call(Utils.bookmarks.first.title);

      expect(result, true);
    });

    test('should return false when repository returns false', () async {
      fakeRepository.setBookmarks(Utils.bookmarks);

      final result = await IsBookmarkedUseCase(fakeRepository).call('test');

      expect(result, false);
    });

    test(
      'should throw an exception when repository throws an exception',
      () async {
        fakeRepository.setShouldFail();

        expectLater(
          () => IsBookmarkedUseCase(
            fakeRepository,
          ).call(Utils.bookmarks.first.title),
          throwsA(isA<Exception>()),
        );

        expect(
          () => IsBookmarkedUseCase(
            fakeRepository,
          ).call(Utils.bookmarks.first.title),
          throwsA(
            predicate((e) => e is Exception && e.toString().contains('Error')),
          ),
        );
      },
    );
  });

  group('remove bookmark', () {
    test(
      'should remove bookmark from repository when repository returns success',
      () async {
        fakeRepository.setBookmarks(Utils.bookmarks);

        await RemoveBookmarkUseCase(
          fakeRepository,
        ).call(Utils.bookmarks.first.title);

        final bookmarks = await getBookmarksUseCase(NoParams());

        expect(bookmarks.length, 0);
      },
    );

    test(
      'should remove bookmark from repository when repository returns fail',
      () async {
        fakeRepository.setBookmarks(Utils.bookmarks);

        await RemoveBookmarkUseCase(fakeRepository).call('Android');

        final bookmarks = await getBookmarksUseCase(NoParams());

        expect(bookmarks.length, 1);
      },
    );

    test(
      'should throw an exception when repository throws an exception',
      () async {
        fakeRepository.setShouldFail();

        expectLater(
          () => RemoveBookmarkUseCase(
            fakeRepository,
          ).call(Utils.bookmarks.first.title),
          throwsA(isA<Exception>()),
        );

        expect(
          () => RemoveBookmarkUseCase(
            fakeRepository,
          ).call(Utils.bookmarks.first.title),
          throwsA(
            predicate((e) => e is Exception && e.toString().contains('Error')),
          ),
        );
      },
    );
  });
}
