import 'package:flutter/material.dart';
import 'package:resto_app/data/preferences.dart';

class PreferenceProvider extends ChangeNotifier{
  Preferences preferences;

  PreferenceProvider({required this.preferences}) {
    _getDailyReminderPreferences();
  }

  bool _isDailyReminderActive = false;
  bool get isDailyReminderActive => _isDailyReminderActive;

  void _getDailyReminderPreferences() async {
    _isDailyReminderActive = await preferences.isDailyReminderActive;
    notifyListeners();
  }

  void enableDailyReminder(bool value) {
    preferences.setDailyReminder(value);
    _getDailyReminderPreferences();
  }
}