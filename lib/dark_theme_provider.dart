import 'package:flutter/material.dart';
import 'package:news_app/preferences.dart';

class DarkThemeProvider with ChangeNotifier {
  Preferences darkThemePreference = Preferences();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}