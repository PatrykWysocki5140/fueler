import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Validator {
  static String? validateEmail(String value, BuildContext context) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '🚩 ${AppLocalizations.of(context)!.validEmail}';
    } else {
      return null;
    }
  }

  static String? validateDropDefaultData(value) {
    if (value == null) {
      return 'Please select an item.';
    } else {
      return null;
    }
  }

  static String? validatePasswordRegister(
      String value, String nextpass, BuildContext context) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '🚩 ${AppLocalizations.of(context)!.validPassLeng}';
    } else if (value != nextpass) {
      return '🚩 ${AppLocalizations.of(context)!.validPass}';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value, BuildContext context) {
    //Pattern pattern = r'^.{6,}$';
    Pattern pattern = r'^.{4,}$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '🚩 ${AppLocalizations.of(context)!.validPassLeng}.';
    } else {
      return null;
    }
  }

  static String? validateVeryficationCode(String value, BuildContext context) {
    //Pattern pattern = r'^.{6,}$';
    Pattern pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '🚩 ${AppLocalizations.of(context)!.validVeryfiCodeLeng}.';
    } else {
      return null;
    }
  }

  static String? validateName(String value, BuildContext context) {
    if (value.length < 3) {
      return '🚩 ${AppLocalizations.of(context)!.validName}';
    } else {
      return null;
    }
  }

  static String? validateText(String value, BuildContext context) {
    if (value.isEmpty) {
      return '🚩 ${AppLocalizations.of(context)!.validText}';
    } else {
      return null;
    }
  }

  static String? validatePrice(String value, BuildContext context) {
    Pattern pattern = r'(^\d*\.?\d*)$';
    RegExp regex = RegExp(pattern as String);
    if (value.isEmpty) {
      return '🚩 ${AppLocalizations.of(context)!.validEmptyField}';
    } else if (!regex.hasMatch(value)) {
      return '🚩 ${AppLocalizations.of(context)!.validPrice}.';
    } else {
      return null;
    }
  }

  static String? validateCoordinatesLatitude(
      String value, BuildContext context) {
    Pattern pattern = r'^-?([0-8]?[0-9]|90)(\.[0-9]{1,10})$';
    RegExp regex = RegExp(pattern as String);
    if (value.isEmpty) {
      return '🚩 ${AppLocalizations.of(context)!.validEmptyField}';
    } else if (!regex.hasMatch(value)) {
      return '🚩 ${AppLocalizations.of(context)!.validCoordinates}.';
    } else {
      return null;
    }
  }

  static String? validateCoordinatesLongitude(
      String value, BuildContext context) {
    Pattern pattern = r'^-?([0-9]{1,2}|1[0-7][0-9]|180)(\.[0-9]{1,10})$';
    RegExp regex = RegExp(pattern as String);
    if (value.isEmpty) {
      return '🚩 ${AppLocalizations.of(context)!.validEmptyField}';
    } else if (!regex.hasMatch(value)) {
      return '🚩 ${AppLocalizations.of(context)!.validCoordinates}.';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String value, BuildContext context) {
    if (value.length < 9) {
      return '🚩 ${AppLocalizations.of(context)!.validPhone}';
    } else {
      return null;
    }
  }
}
