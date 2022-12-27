// ignore: file_names
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:fueler/model/API_Model/PriceEntries.dart';
import 'package:fueler/model/API_Model/User.dart';
import 'package:fueler/model/API_Model/UserPrivilegeLevel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/API_Model/Api_service.dart';

class GoogleMaps with ChangeNotifier {
  //String baseUrl = "http://fueler.data.awrzawinski.xyz";
  //String preferencesKeyToken = "token";
  //String preferencesKeyUser = "userData";
  //String preferencesKeyUserExist = "userExist";
  String preferencesKeyNightMode = "dark_mode_enabled";
  String mapTheme = "";

  setMapTheme() async {
    final prefs = await SharedPreferences.getInstance();

    bool? _darkmode = prefs.getBool(preferencesKeyNightMode);

    log(" _darkmode: " + _darkmode.toString());
    if (_darkmode == true) {
      mapTheme = "assets/mapstyle/map_style_dark.json";
    } else {
      mapTheme = "assets/mapstyle/map_style_main.json";
    }
    log(" mapTheme: " + mapTheme);
  }
}
