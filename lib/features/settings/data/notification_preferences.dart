import 'package:shared_preferences/shared_preferences.dart';

class NotificationPreferences {
  static const _key = 'daily_notification';
  final SharedPreferences sharedPreferences;

  NotificationPreferences(this.sharedPreferences);

  Future<void> setEnabled(bool value) async {
    await sharedPreferences.setBool(_key, value);
  }

  Future<bool> isEnabled() async {
    return sharedPreferences.getBool(_key) ?? false;
  }
}
