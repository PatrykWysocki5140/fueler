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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            backgroundColor:
                isDarkTheme ? GetColors.darkAccent : GetColors.lightAccent,
            foregroundColor:
                isDarkTheme ? GetColors.darkMainFont : GetColors.lightMainFont,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
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
            color: isDarkTheme
                ? GetColors.mainColorDark
                : GetColors.mainColorLight,
          ),
          labelStyle: TextStyle(
            color:
                isDarkTheme ? GetColors.darkMainFont : GetColors.lightMainFont,
          ),
          suffixIconColor: GetColors.error,
          // isDarkTheme ? GetColors.mainColorDark : GetColors.mainColorLight,
          filled: true,
          fillColor: isDarkTheme ? GetColors.darkAccent : GetColors.lightAccent,
          focusedBorder: OutlineInputBorder(
            //borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(width: 3, color: GetColors.warning),
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
        /// styl listy

        cardTheme: CardTheme(
          color: isDarkTheme ? GetColors.darkAccent : GetColors.lightAccent,
        ),
        ////////////////////////////////////////////////////////////////////
        ///
        /// styl listy rozwijanej
        canvasColor:
            isDarkTheme ? GetColors.mainColorDark : GetColors.mainColorLight
        ////////////////////////////////////////////////////////////////////
        ///
        ///
        );
  }
}
