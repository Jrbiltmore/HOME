import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager with ChangeNotifier {
  static const String _localeKey = 'userLocale';
  Locale? _currentLocale;

  LocaleManager() {
    _loadLocale();
  }

  Locale? get currentLocale => _currentLocale;

  void _loadLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localeCode = prefs.getString(_localeKey);
    if (localeCode != null) {
      _currentLocale = Locale(localeCode);
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
    _currentLocale = locale;
    notifyListeners();
  }
}