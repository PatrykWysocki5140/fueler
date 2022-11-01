import 'package:flutter/material.dart';
import 'package:fueler/bloc%20pattern/settings/get_colors.dart';

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
