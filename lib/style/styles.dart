import 'package:bart/bart/widgets/bottom_bar/bottom_bar.dart';
import 'package:bart/bart/widgets/bottom_bar/styles/bottom_bar_material.dart';
import 'package:flutter/cupertino.dart';
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
      /// Przciski
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor:
            isDarkTheme ? GetColors.darkAccent : GetColors.lightAccent,
        foregroundColor:
            isDarkTheme ? GetColors.darkMainFont : GetColors.lightMainFont,
        hoverColor:
            isDarkTheme ? GetColors.mainColorDark : GetColors.mainColorLight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          backgroundColor:
              isDarkTheme ? GetColors.darkAccent : GetColors.lightAccent,
          foregroundColor:
              isDarkTheme ? GetColors.darkMainFont : GetColors.lightMainFont,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          foregroundColor:
              isDarkTheme ? GetColors.darkMainFont : GetColors.lightMainFont,
        ),
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
      textSelectionTheme: TextSelectionThemeData(
        cursorColor:
            isDarkTheme ? GetColors.mainColorDark : GetColors.mainColorLight,
        selectionColor:
            isDarkTheme ? GetColors.mainColorDark : GetColors.mainColorLight,
        selectionHandleColor:
            isDarkTheme ? GetColors.mainColorDark : GetColors.mainColorLight,
      ),
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
                  : GetColors.lightMainFont),
          subtitle1: TextStyle(
              color: isDarkTheme
                  ? GetColors.darkMainFont
                  : GetColors.lightMainFont),
          subtitle2: TextStyle(
              color: isDarkTheme
                  ? GetColors.darkMainFont
                  : GetColors.lightMainFont)),

      ////////////////////////////////////////////////////////////////////
      ///
      /// styl formularza

      inputDecorationTheme: InputDecorationTheme(
        errorStyle: TextStyle(
          color: GetColors.error,
        ),
        hintStyle: TextStyle(
          color:
              isDarkTheme ? GetColors.mainColorDark : GetColors.mainColorLight,
        ),
        labelStyle: TextStyle(
          color: isDarkTheme ? GetColors.darkMainFont : GetColors.lightMainFont,
        ),
        suffixIconColor:
            isDarkTheme ? GetColors.mainColorDark : GetColors.mainColorLight,
        filled: true,
        fillColor: isDarkTheme ? GetColors.darkAccent : GetColors.lightAccent,
        focusedBorder: OutlineInputBorder(
          //borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: GetColors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: isDarkTheme
                ? GetColors.mainColorDark
                : GetColors.mainColorLight,
            width: 2.0,
          ),
        ),
      ),
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
