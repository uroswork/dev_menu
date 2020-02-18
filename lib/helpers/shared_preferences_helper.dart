import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

mixin SharedPreferencesHelper {
  /// Getter
  Future<bool> getSharedPreference(String title) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(title) ?? false;
  }

  /// Setter
  Future<bool> setSharedPreference(String title, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(title, value);
  }

  /// Clear all shared preferences
  static Future<bool> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.clear();
  }
}
