import 'package:news_app/core/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPreferences {
  final SharedPreferences sharedPreferences;

  NotificationPreferences(this.sharedPreferences);

  Future<void> setEnabled(bool value) async {
    await sharedPreferences.setBool(Constants.notificationKey, value);
  }

  Future<bool> isEnabled() async {
    return sharedPreferences.getBool(Constants.notificationKey) ?? false;
  }
}
