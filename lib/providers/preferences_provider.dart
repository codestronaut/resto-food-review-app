import 'package:flutter/material.dart';
import 'package:resto/data/helper/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  bool _isDailyRestoActive = false;
  bool get isDailyRestoActive => _isDailyRestoActive;

  PreferencesProvider({required this.preferencesHelper}) {
    _getThemePreferences();
    _getDailyRestoPreferences();
  }

  void _getThemePreferences() async {
    _isDarkMode = await preferencesHelper.isDarkMode;
    notifyListeners();
  }

  void _getDailyRestoPreferences() async {
    _isDailyRestoActive = await preferencesHelper.isDailyRestoActive;
    notifyListeners();
  }

  void enableDarkMode(bool value) async {
    preferencesHelper.setDarkMode(value);
    _getThemePreferences();
  }

  void enableDailyResto(bool value) async {
    preferencesHelper.setDailyResto(value);
    _getDailyRestoPreferences();
  }
}
