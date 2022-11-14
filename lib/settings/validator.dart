import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Validator {
  static String? validateEmail(String value, BuildContext context) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '🚩 ${AppLocalizations.of(context)!.nullValidator}';
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
      return '🚩 ${AppLocalizations.of(context)!.nullValidator}';
    } else if (value != nextpass) {
      return '🚩 ${AppLocalizations.of(context)!.nullValidator}';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value, BuildContext context) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '🚩 ${AppLocalizations.of(context)!.nullValidator}.';
    } else {
      return null;
    }
  }

  static String? validateName(String value, BuildContext context) {
    if (value.length < 3) {
      return '🚩 ${AppLocalizations.of(context)!.nullValidator}';
    } else {
      return null;
    }
  }

  static String? validateText(String value, BuildContext context) {
    if (value.isEmpty) {
      return '🚩 ${AppLocalizations.of(context)!.nullValidator}';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String value, BuildContext context) {
    if (value.length != 11) {
      return '🚩 ${AppLocalizations.of(context)!.nullValidator}';
    } else {
      return null;
    }
  }
}
