import 'package:flutter/material.dart';

import '../../data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyPreferences();
  }

  bool _reminderActive = false;
  bool get isDailyReminderActive => _reminderActive;

  void _getDailyPreferences() async {
    _reminderActive = await preferencesHelper.reminderActive;
    notifyListeners();
  }

  void enableDailyReminder(bool value) {
    preferencesHelper.setReminder(value);
    _getDailyPreferences();
  }
}
