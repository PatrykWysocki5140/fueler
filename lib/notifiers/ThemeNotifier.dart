import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../bloc pattern/style/styles.dart';

class NightMode extends ChangeNotifier {
  final String preferencesKey = "dark_mode_enabled";

  Future<ThemeData> getTheme() => SharedPreferences.getInstance().then(
      (value) => Styles.themeData(value.getBool(preferencesKey) ?? false));

  Future<bool> get enabled => SharedPreferences.getInstance()
      .then((value) => value.getBool(preferencesKey) ?? false);

  Future<void> switchTheme() async {
    await SharedPreferences.getInstance().then((value) => value.setBool(
        preferencesKey, !(value.getBool(preferencesKey) ?? true)));
    notifyListeners();
  }
}
