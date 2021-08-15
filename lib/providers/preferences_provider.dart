import 'package:flutter/material.dart';
import 'package:resto/data/preferences/preferences_helper.dart';
import 'package:resto/shared/styles.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getDailyRestaurant();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyRestaurantActive = false;
  bool get isDailyRestaurantActive => _isDailyRestaurantActive;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getDailyRestaurant() async {
    _isDailyRestaurantActive = await preferencesHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableDailyRestaurant(bool value) {
    preferencesHelper.setDailyRestaurant(value);
    _getDailyRestaurant();
  }

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;
}
