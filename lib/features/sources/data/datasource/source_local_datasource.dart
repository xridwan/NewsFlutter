import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class SourceLocalDataSource {
  const SourceLocalDataSource();

  Future<void> cachedSources(
    String key,
    List<Map<String, dynamic>> data,
  );

  Future<List<Map<String, dynamic>>> getCachedSources(String key);
}

class SourceLocalDataSourceImpl implements SourceLocalDataSource {
  final SharedPreferences _preferences;

  SourceLocalDataSourceImpl(this._preferences);

  @override
  Future<void> cachedSources(
    String key,
    List<Map<String, dynamic>> data,
  ) async {
    final jsonString = jsonEncode(data);
    await _preferences.setString(key, jsonString);
  }


  @override
  Future<List<Map<String, dynamic>>> getCachedSources(String key) async {
    final jsonString = _preferences.getString(key);
    if (jsonString != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    }
    return [];
  }
}
