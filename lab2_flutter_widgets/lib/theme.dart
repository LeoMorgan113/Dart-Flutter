import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _selectedTheme;
  late SharedPreferences prefs;

  ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: Colors.black
  );

  ThemeData light = ThemeData(
    primarySwatch: Colors.red,
    brightness: Brightness.light,
  );

  ThemeProvider(bool? darkThemeOn) {
    if (darkThemeOn!= null && darkThemeOn) {
      _selectedTheme = dark;
    } else {
      _selectedTheme = light;
    }
  }

  Future<void> swapTheme() async {
    prefs = await SharedPreferences.getInstance();

    if (_selectedTheme == dark) {
      _selectedTheme = light;
      await prefs.setBool("darkTheme", false);
    } else {
      _selectedTheme = dark;
      await prefs.setBool("darkTheme", true);
    }

    notifyListeners();
  }

  ThemeData get getTheme => _selectedTheme;
}