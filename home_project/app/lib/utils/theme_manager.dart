import 'package:flutter/material.dart';
import 'package:app/lib/themes/dark_theme.dart';
import 'package:app/lib/themes/light_theme.dart';

class ThemeManager with ChangeNotifier {
  ThemeData _themeData;
  bool _isDarkMode;

  ThemeManager({bool isDarkMode = false})
      : _isDarkMode = isDarkMode,
        _themeData = isDarkMode ? darkTheme : lightTheme;

  bool get isDarkMode => _isDarkMode;

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _themeData = _isDarkMode ? darkTheme : lightTheme;
    notifyListeners();
  }
}