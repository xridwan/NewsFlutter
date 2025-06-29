import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/core/database/database_helper.dart';
import 'package:news_app/features/bookmark/data/datasource/bookmark_local_datasource.dart';
import 'package:news_app/features/bookmark/data/dto/bookmark_dto.dart';
import 'package:sqflite/sqflite.dart';

class MockDatabase extends Mock implements Database {}

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  late BookmarkLocalDatasource datasource;
  late MockDatabaseHelper helper;
  late MockDatabase database;

  setUp(() {
    database = MockDatabase();
    helper = MockDatabaseHelper();

    when(() => helper.database).thenAnswer((_) async => database);
    when(() => helper.tableName).thenReturn('bookmark');

    datasource = BookmarkLocalDatasourceImpl(helper);
  });

  test('should return list of BookmarkDto from getBookmarks()', () async {
    final dataMap = [
      {
        "title": "News Test",
        "author": "Author",
        "description": "Desc",
        "publishedAt": "2024-01-01",
        "urlToImage": "url",
        "sourceId": "cnn",
      },
    ];

    when(() => database.query(any())).thenAnswer((_) async => dataMap);

    final result = await datasource.getBookmarks();

    expect(result, isA<List<BookmarkDto>>());
    expect(result.first.title, equals("News Test"));
  });

  test('should call insert() on addBookmark()', () async {
    final bookmark = BookmarkDto(
      title: "News Test",
      author: "Author",
      description: "Desc",
      publishedAt: "2024-01-01",
      urlToImage: "url",
      sourceId: "cnn",
    );

    when(() => database.insert(any(), any())).thenAnswer((_) async => 1);

    await datasource.addBookmark(bookmark);

    verify(() => database.insert(any(), any())).called(1);
  });

  test('should call delete() on removeBookmark()', () async {
    when(
      () => database.delete(
        any(),
        where: any(named: 'where'),
        whereArgs: any(named: 'whereArgs'),
      ),
    ).thenAnswer((_) async => 1);

    await datasource.removeBookmark("News Test");

    verify(
      () => database.delete(
        any(),
        where: any(named: 'where'),
        whereArgs: any(named: 'whereArgs'),
      ),
    ).called(1);
  });

  test('should return true if bookmark exists', () async {
    when(
      () => database.query(
        any(),
        where: any(named: "where"),
        whereArgs: any(named: 'whereArgs'),
      ),
    ).thenAnswer((_) async => [{}]);

    final result = await datasource.isBookmarked('News Testing');

    expect(result, isTrue);
  });

  test('should return false if bookmark not exists', () async {
    when(
      () => database.query(
        any(),
        where: any(named: "where"),
        whereArgs: any(named: 'whereArgs'),
      ),
    ).thenAnswer((_) async => []);

    final result = await datasource.isBookmarked('News Testing');

    expect(result, isFalse);
  });
}
