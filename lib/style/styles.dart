import 'package:bart/bart/widgets/bottom_bar/bottom_bar.dart';
import 'package:bart/bart/widgets/bottom_bar/styles/bottom_bar_material.dart';
import 'package:flutter/material.dart';

import '../settings/Get_colors.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme) {
    return ThemeData(
      // Nagłówek
      appBarTheme: AppBarTheme(
        backgroundColor:
            isDarkTheme ? GetColors.darkAccent : GetColors.lightAccent,
        foregroundColor:
            isDarkTheme ? GetColors.darkMainFont : GetColors.lightMainFont,
      ),
      ////////////////////////////////////////////////////////////////////
      ///
      /// Przcisk "floating"
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor:
            isDarkTheme ? GetColors.darkAccent : GetColors.lightAccent,
        foregroundColor:
            isDarkTheme ? GetColors.darkMainFont : GetColors.lightMainFont,
        hoverColor:
            isDarkTheme ? GetColors.mainColorDark : GetColors.mainColorLight,
      ),
      ////////////////////////////////////////////////////////////////////
      ///
      /// tło dolengo menu - nieaktywne
      //canvasColor: isDarkTheme ? GetColors.darkAccent : GetColors.lightAccent,
      ////////////////////////////////////////////////////////////////////
      ///
      /// Dolne menu
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor:
            isDarkTheme ? GetColors.darkAccent : GetColors.lightAccent,
        selectedItemColor:
            isDarkTheme ? GetColors.mainColorDark : GetColors.mainColorLight,
        unselectedItemColor:
            isDarkTheme ? GetColors.darkMainFont : GetColors.lightMainFont,
      ),

      ////////////////////////////////////////////////////////////////////
      ///
      /// style konkretnych stron
      scaffoldBackgroundColor:
          isDarkTheme ? GetColors.darkShades : GetColors.lightShades,
      ////////////////////////////////////////////////////////////////////
      ///
      /// styl tekstów - globalny
      textTheme: TextTheme(
          bodyText1: TextStyle(
              color: isDarkTheme
                  ? GetColors.darkMainFont
                  : GetColors.lightMainFont),
          bodyText2: TextStyle(
              color: isDarkTheme
                  ? GetColors.darkMainFont
                  : GetColors.lightMainFont),
          button: TextStyle(
              color: isDarkTheme
                  ? GetColors.darkMainFont
                  : GetColors.lightMainFont)),
      ////////////////////////////////////////////////////////////////////
      ///
      ///
/*
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
        )*/
    );
  }
}
