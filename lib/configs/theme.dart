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
          color: Color.fromARGB(255, 24, 118, 210)
        ),
        scaffoldBackgroundColor: Colors.grey[900],
        primaryColor: Color.fromARGB(255, 24, 118, 210),
        cardColor: Colors.grey[850],
        accentColor: Colors.indigo[400],
        backgroundColor: Colors.grey[900],
        focusColor: Colors.blueGrey[600],
        buttonColor: Colors.pink[600],
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.pink[600],
        ),
        
      );
    } else {
      return ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          color: Color.fromARGB(255, 24, 118, 210)
        ),
        scaffoldBackgroundColor: Colors.grey[300],
        primaryColor: Color.fromARGB(255, 24, 118, 210),
        cardColor: Colors.grey[300],
        accentColor: Colors.indigo[400],
        backgroundColor: Colors.grey[100],
        focusColor: Colors.blueGrey[600],
        buttonColor: Colors.pink[600],
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.pink[600],
        ),
        
      );
    }
  }
}