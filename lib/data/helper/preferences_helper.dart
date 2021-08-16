import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  PreferencesHelper({required this.sharedPreferences});

  static const DARK_MODE = 'DARK_MODE';
  static const DAILY_RESTO = 'DAILY_RESTO';

  void setDarkMode(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DARK_MODE, value);
  }

  void setDailyResto(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_RESTO, value);
  }

  Future<bool> get isDarkMode async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DARK_MODE) ?? false;
  }

  Future<bool> get isDailyRestoActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_RESTO) ?? false;
  }
}
