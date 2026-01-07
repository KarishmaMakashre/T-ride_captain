import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getInt('theme_mode');
    if (savedMode != null) {
      _themeMode = ThemeMode.values[savedMode];
    }
    notifyListeners();
  }

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('theme_mode', mode.index);
    });
    notifyListeners();
  }
}
