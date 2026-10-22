import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences(this._prefs);

  final SharedPreferences _prefs;

  static const _themeModeKey = 'theme_mode';
  static const _localeKey = 'locale';
  static const _onboardingDoneKey = 'onboarding_done';
  static const _isLoggedInKey = 'is_logged_in';

  ThemeMode get themeMode {
    final value = _prefs.getString(_themeModeKey);
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<bool> setThemeMode(ThemeMode mode) {
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    return _prefs.setString(_themeModeKey, value);
  }

  String get locale => _prefs.getString(_localeKey) ?? 'en';

  Future<bool> setLocale(String locale) {
    assert(locale == 'en' || locale == 'ur');
    return _prefs.setString(_localeKey, locale);
  }

  bool get onboardingDone => _prefs.getBool(_onboardingDoneKey) ?? false;

  Future<bool> setOnboardingDone(bool value) {
    return _prefs.setBool(_onboardingDoneKey, value);
  }

  bool get isLoggedIn => _prefs.getBool(_isLoggedInKey) ?? false;

  Future<bool> setLoggedIn(bool value) {
    return _prefs.setBool(_isLoggedInKey, value);
  }

  Future<bool> clearSession() async {
    final results = await Future.wait([
      _prefs.setBool(_isLoggedInKey, false),
    ]);
    return results.every((r) => r);
  }
}
