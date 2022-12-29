// ignore: file_names
import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/API_Model/Api_service.dart';
import 'package:http/http.dart' as http;

class GoogleMaps with ChangeNotifier {
  //String baseUrl = "http://fueler.data.awrzawinski.xyz";
  //String preferencesKeyToken = "token";
  //String preferencesKeyUser = "userData";
  //String preferencesKeyUserExist = "userExist";
  String preferencesKeyNightMode = "dark_mode_enabled";
  String mapTheme = "";
  late bool isDarkTheme;
  String mapApiKey = "AIzaSyBgTRaSwoKFHa5-pFg6JJOgR5VPw6Cb8Ds";

  setMapTheme() async {
    final prefs = await SharedPreferences.getInstance();

    bool? _darkmode = prefs.getBool(preferencesKeyNightMode);

    log(" _darkmode: " + _darkmode.toString());
    if (_darkmode == true) {
      isDarkTheme = true;
      mapTheme = "assets/mapstyle/map_style_dark.json";
    } else {
      isDarkTheme = false;
      mapTheme = "assets/mapstyle/map_style_main.json";
    }
    log(" mapTheme: " + mapTheme);
  }

  Future<bool> getMapThemeValue() async {
    final prefs = await SharedPreferences.getInstance();

    bool? _darkmode = prefs.getBool(preferencesKeyNightMode);

    log("get _darkmode: " + _darkmode.toString());
    if (_darkmode == true) {
      log("get _darkmode: return true");
      return true;
    } else {
      log("get _darkmode: return false");
      return false;
    }
  }

//// nie działa
  Future<String?> getAddressFromLatLng(double lat, double lng) async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    //final url = '$_host?key=$mapApiKey&language=en&latlng=$lat,$lng';
    final url = '$_host?latlng=$lat,$lng&key=$mapApiKey';
    if (lat != null && lng != null) {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];
        log("Adres: $_formattedAddress");
        return _formattedAddress;
      } else
        return null;
    } else
      return null;
  }

  /////////
}
