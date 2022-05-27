import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme) {
    return ThemeData(
      primarySwatch: Colors.red,
      primaryColor:
          isDarkTheme ? Color.fromARGB(255, 153, 14, 14) : Colors.white,
      backgroundColor:
          isDarkTheme ? Color.fromARGB(255, 166, 44, 44) : Color(0xFFF1F5FB),
      indicatorColor:
          isDarkTheme ? Color.fromARGB(255, 174, 29, 43) : Color(0xffCBDCF8),
      hintColor:
          isDarkTheme ? Color.fromARGB(255, 144, 35, 31) : Color(0xffEECED3),
      highlightColor:
          isDarkTheme ? Color.fromARGB(255, 169, 30, 14) : Color(0xffFCE192),
      hoverColor:
          isDarkTheme ? Color.fromARGB(255, 19, 19, 162) : Color(0xff4285F4),
      focusColor:
          isDarkTheme ? Color.fromARGB(255, 108, 10, 28) : Color(0xffA8DAB5),
      disabledColor: Color.fromARGB(255, 207, 12, 12),
      cardColor: isDarkTheme ? Color.fromARGB(255, 184, 37, 37) : Colors.white,
      canvasColor:
          isDarkTheme ? Color.fromARGB(255, 35, 35, 35) : Colors.grey[50],
      // ignore: deprecated_member_use, prefer_const_constructors
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.red,
      ),
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor:
              isDarkTheme ? Color.fromARGB(255, 162, 30, 30) : Colors.black),
    );
  }
}
