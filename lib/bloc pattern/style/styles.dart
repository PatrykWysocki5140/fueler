import 'package:flutter/material.dart';
import 'package:fueler/widgets/basic_widgets.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme) {
    return ThemeData(
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
        textTheme: TextTheme(
            bodyText1:
                TextStyle(color: isDarkTheme ? GetColors.red : GetColors.black),
            bodyText2:
                TextStyle(color: isDarkTheme ? GetColors.red : GetColors.black),
            button: TextStyle(
                color: isDarkTheme ? GetColors.red : GetColors.white)),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
          isDarkTheme ? GetColors.red : GetColors.black,
        ))),
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
        ));
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
