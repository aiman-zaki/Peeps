import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController {

  static setTheme(bool theme) async {
     SharedPreferences preferences = await SharedPreferences.getInstance();
     preferences.setBool('theme', theme);

  }
  static getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool theme = preferences.getBool("theme") == null ? true : preferences.getBool("theme");
    if(theme || theme == null){
      return ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          color: Color.fromARGB(255, 77,44, 145)
        ),
        scaffoldBackgroundColor: Colors.grey[900],
        primaryColor: Color.fromARGB(255, 126, 87, 194),
        cardColor: Color.fromARGB(50, 173, 102, 227),
        accentColor: Colors.pink[400],
        backgroundColor: Colors.grey[900],
        focusColor: Colors.blueGrey[600],
        buttonColor: Colors.pink[600],
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.pink[600],
        )
      );
    } else {
      return ThemeData(
        brightness: Brightness.light
      );
    }
  }
}