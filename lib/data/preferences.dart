import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final Future<SharedPreferences> sharedPreferences;

  Preferences({required this.sharedPreferences});

  static const DAILY_REMINDER = 'DAILY_REMINDER';

  Future<bool> get isDailyReminderActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_REMINDER) ?? false;
  }

  void setDailyReminder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_REMINDER, value);
  }
}
