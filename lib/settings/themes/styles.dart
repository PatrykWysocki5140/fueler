import 'package:flutter/material.dart';
import 'package:fueler/widgets/basic_widgets.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme) {
    return ThemeData(
        //primarySwatch: isDarkTheme ? Colors.red : Colors.white,
        //backgroundColor: isDarkTheme ? GetColors.lightBlack : GetColors.white,
        //primaryColor: isDarkTheme ? GetColors.lightBlack : GetColors.white,
        //indicatorColor: isDarkTheme ? GetColors.lightBlack : GetColors.white,
        //hintColor: isDarkTheme ? GetColors.lightBlack : GetColors.white,
        //highlightColor: isDarkTheme ? GetColors.lightBlack : GetColors.white,
        //focusColor: isDarkTheme ? GetColors.black : GetColors.red,
        //disabledColor: isDarkTheme ? GetColors.red : GetColors.white,
        hoverColor: isDarkTheme ? GetColors.black : GetColors.red,
        appBarTheme: AppBarTheme(
          backgroundColor: isDarkTheme ? GetColors.gray : GetColors.white,
          foregroundColor: isDarkTheme ? GetColors.red : GetColors.black,
        ),
        canvasColor:
            isDarkTheme ? GetColors.lightBlack : GetColors.white, //tło wewnątrz
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: isDarkTheme ? GetColors.gray : GetColors.gray,
          foregroundColor: isDarkTheme ? GetColors.red : GetColors.black,
          hoverColor: isDarkTheme ? GetColors.black : GetColors.red,
        ),
        bottomAppBarColor: isDarkTheme ? GetColors.gray : GetColors.white,
        iconTheme: IconThemeData(
          color: isDarkTheme ? GetColors.red : GetColors.black,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: isDarkTheme ? GetColors.red : GetColors.black,
          ),
          fillColor: GetColors.green,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: GetColors.green,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: GetColors.red,
              width: 2.0,
            ),
          ),
        )

/*
      primarySwatch: Colors.red,
      primaryColor:
          isDarkTheme ? const Color.fromARGB(255, 153, 14, 14) : Colors.white,
      backgroundColor: isDarkTheme
          ? const Color.fromARGB(255, 166, 44, 44)
          : const Color(0xFFF1F5FB),
      indicatorColor: isDarkTheme
          ? const Color.fromARGB(255, 174, 29, 43)
          : const Color(0xffCBDCF8),
      hintColor: isDarkTheme
          ? const Color.fromARGB(255, 144, 35, 31)
          : const Color(0xffEECED3),
      highlightColor: isDarkTheme
          ? const Color.fromARGB(255, 169, 30, 14)
          : const Color(0xffFCE192),
      hoverColor: isDarkTheme
          ? const Color.fromARGB(255, 19, 19, 162)
          : const Color.fromARGB(255, 119, 131, 150),
      focusColor: isDarkTheme
          ? const Color.fromARGB(255, 108, 10, 28)
          : const Color(0xffA8DAB5),
      disabledColor: const Color.fromARGB(255, 207, 12, 12),
      cardColor:
          isDarkTheme ? const Color.fromARGB(255, 184, 37, 37) : Colors.white,
      canvasColor:
          isDarkTheme ? const Color.fromARGB(255, 35, 35, 35) : Colors.grey[50],
      // ignore: deprecated_member_use, prefer_const_constructors
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.red,
      ),
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,

      appBarTheme: AppBarTheme(
        backgroundColor: isDarkTheme
            ? const Color.fromARGB(255, 108, 10, 28)
            : const Color(0xffA8DAB5),
      ),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme
              ? const Color.fromARGB(255, 162, 30, 30)
              : Colors.black),*/
        );
  }
}

class GetColors {
  static Color red = Color.fromARGB(255, 223, 31, 31);
  static Color white = Color.fromARGB(255, 237, 235, 235);
  static Color lightBlack = Color.fromARGB(255, 31, 30, 30);
  static Color black = Color.fromARGB(255, 0, 0, 0);
  static Color gray = Color.fromARGB(255, 91, 90, 90);
  static Color green = Color.fromARGB(255, 16, 154, 16);
  static Color yellow = Color.fromARGB(255, 192, 199, 11);
  static Color orange = Color.fromARGB(255, 212, 100, 8);
}
