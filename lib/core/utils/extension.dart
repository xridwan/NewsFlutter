import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateFormatExtension on String {
  String toFormattedDate() {
    try {
      DateTime dateTime = DateTime.parse(this).toLocal();
      return DateFormat("EEEE, dd/MM/yy").format(dateTime);
    } catch (e) {
      return "Invalid Date";
    }
  }
}

extension ShowSnackBarExtension on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.grey[800],
      ),
    );
  }
}
