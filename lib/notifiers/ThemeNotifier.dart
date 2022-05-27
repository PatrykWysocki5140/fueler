import 'package:flutter/material.dart';
import 'package:fueler/settings/themes/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
class NightMode extends ChangeNotifier {
  ThemeData themeMode = ThemeData.light();
  bool _isEnabled = false;
  set userthemeMode(ThemeData themedata) {
    themeMode = themedata;
    notifyListeners();
  }

  getTheme() {
    var themevalue;
    SharedPreferences.getInstance().then((v) {
      themevalue = v.getBool("night_mode_enabled");
    }).then((_) {
      if (themevalue) {
        themeMode = ThemeData.dark();
        notifyListeners();
        _isEnabled = true;
      }
    });

    return themeMode;
  }

  set enabled(value) {
    _isEnabled = value;
    SharedPreferences.getInstance().then((v) {
      v.setBool("night_mode_enabled", _isEnabled);
    });
  }

  getEnabled() {
    return _isEnabled;
  }
}
*/
class NightMode extends ChangeNotifier {
  ThemeData themeMode = ThemeData.light();
  bool _isEnabled = false;
  set userthemeMode(ThemeData themedata) {
    themeMode = themedata;
    notifyListeners();
  }

  getTheme() {
    var themevalue;
    SharedPreferences.getInstance().then((v) {
      themevalue = v.getBool("night_mode_enabled");
    }).then((_) {
      if (themevalue) {
        themeMode = Styles.themeData(true);
        notifyListeners();
        _isEnabled = true;
      }
    });

    return themeMode;
  }

  set enabled(value) {
    _isEnabled = value;
    SharedPreferences.getInstance().then((v) {
      v.setBool("night_mode_enabled", _isEnabled);
    });
  }

  getEnabled() {
    return _isEnabled;
  }
}
