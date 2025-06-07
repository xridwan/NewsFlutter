import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ArticleLocalDatasource {
  final SharedPreferences _preferences;

  ArticleLocalDatasource(this._preferences);

  Future<void> cachedArticles(
    String key,
    List<Map<String, dynamic>> data,
  ) async {
    final jsonString = jsonEncode(data);
    await _preferences.setString(key, jsonString);
  }

  Future<List<Map<String, dynamic>>> getCachedArticles(String key) async {
    final jsonString = _preferences.getString(key);
    if (jsonString != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    }
    return [];
  }
}
