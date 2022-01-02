import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themes extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  final _key = 'isDarkMode';
  bool isDark = false;


  setTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, value);
    getTheme();
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getBool(_key) ?? false){
      themeMode = ThemeMode.dark;
      isDark = true;
    }else{
      themeMode = ThemeMode.light;
      isDark = false;
    }
    notifyListeners();
  }
}
