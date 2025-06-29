import 'package:news_app/features/articles/data/datasource/article_local_datasource.dart';
import 'package:news_app/features/sources/data/datasource/source_local_datasource.dart';

class FakeSourceLocalDatasource implements SourceLocalDataSource {
  final Map<String, List<Map<String, dynamic>>> _cache = {};

  @override
  Future<void> cachedSources(
    String key,
    List<Map<String, dynamic>> data,
  ) async {
    _cache[key] = data;
  }

  @override
  Future<List<Map<String, dynamic>>> getCachedSources(String key) async {
    return _cache[key] ?? [];
  }
}

class FakeArticleLocalDatasource implements ArticleLocalDatasource {
  final Map<String, List<Map<String, dynamic>>> _cache = {};

  @override
  Future<void> cachedArticles(
    String key,
    List<Map<String, dynamic>> data,
  ) async {
    _cache[key] = data;
  }

  @override
  Future<List<Map<String, dynamic>>> getCachedArticles(String key) async {
    return _cache[key] ?? [];
  }
}
