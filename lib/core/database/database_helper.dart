import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static const _databaseName = 'bookmark.db';
  static const _databaseVersion = 1;
  static const _tableName = 'bookmark';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDb();
    return _database!;
  }

  Future<Database> _initializeDb() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            title TEXT PRIMARY KEY,
            author TEXT,
            description TEXT,
            publishedAt TEXT,
            urlToImage TEXT,
            sourceId TEXT
          )
        ''');
      },
    );
  }

  String get tableName => _tableName;
}
