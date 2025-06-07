import 'dart:io';

import 'package:news_app/core/errors/failure.dart';
import 'package:sqflite/sqflite.dart';

Failure handleLocalError(Object e) {
  if (e is DatabaseException) {
    return LocalFailure("Database error: ${e.toString()}");
  } else if (e is FormatException) {
    return LocalFailure("Invalid format: ${e.message}");
  } else if (e is FileSystemException) {
    return LocalFailure("Failed to access file system: ${e.message}");
  } else {
    return LocalFailure("Unknown local error: ${e.toString()}");
  }
}