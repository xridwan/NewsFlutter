import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class ArticleLocalDatasource {
  const ArticleLocalDatasource();

  Future<void> cachedArticles(String key, List<Map<String, dynamic>> data);

  Future<List<Map<String, dynamic>>> getCachedArticles(String key);
}

class ArticleLocalDatasourceImpl implements ArticleLocalDatasource {
  final SharedPreferences _preferences;

  ArticleLocalDatasourceImpl(this._preferences);

  @override
  Future<void> cachedArticles(
    String key,
    List<Map<String, dynamic>> data,
  ) async {
    final jsonString = jsonEncode(data);
    await _preferences.setString(key, jsonString);
  }

  @override
  Future<List<Map<String, dynamic>>> getCachedArticles(String key) async {
    final jsonString = _preferences.getString(key);
    if (jsonString != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    }
    return [];
  }
}
