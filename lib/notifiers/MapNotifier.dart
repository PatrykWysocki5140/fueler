// ignore: file_names
import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:fueler/model/API_Model/FuelStation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/API_Model/Api_service.dart';
import 'package:http/http.dart' as http;

class GoogleMaps with ChangeNotifier {
  String baseUrl = "http://fueler.data.awrzawinski.xyz";
  String preferencesKeyToken = "token";
  //String preferencesKeyUser = "userData";
  //String preferencesKeyUserExist = "userExist";
  String preferencesKeyNightMode = "dark_mode_enabled";
  String preferencesKeyDistance = "distance";
  late double distance;
  String mapTheme = "";
  late bool isDarkTheme;
  String mapApiKey = "AIzaSyBgTRaSwoKFHa5-pFg6JJOgR5VPw6Cb8Ds";
  late double userlat;
  late double userlng;
  List<FuelStation> searchFuelStations = List.empty();

  Future<bool> setDistance(String _distance) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(preferencesKeyDistance, _distance);
    return true;
  }

  Future<double?> getDistance() async {
    var prefs = await SharedPreferences.getInstance();
    distance = double.parse(prefs.getString(preferencesKeyDistance)!);
    return distance;
  }

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

  Future<String?> getAddressFromLatLng(double lat, double lng) async {
    userlat = lat;
    userlng = lng;
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

  Future<Response?> getFuelStation() async {
    Response response;
    String url = '$baseUrl/api/fuel-stations/location';
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(preferencesKeyToken);

    await getDistance();
    log("distance: " + distance.toString());
    final queryParameters = {
      'Coordinates.Longitude': userlng,
      'Coordinates.Latitude': userlat,
      'Distance': distance,
    };
    try {
      log(url);
      response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 200) {
        List<FuelStation> _model =
            fuelStationModelFromJson(response.data.toString());
        for (var obj in _model) {
          log("FuelStation:" + obj.toJson().toString());
        }
        if (_model.isNotEmpty) searchFuelStations = _model;
        dio.close();
        return await response;
      }
      return await response;
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return await (e.response);
    }
  }

  Future<Response?> addFuelStation(
      String _longitude, String _latitude, String _name, String _brand) async {
    Response response;
    String url = '$baseUrl/api/fuel-stations';
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(preferencesKeyToken);

    try {
      log(url);
      response = await dio.post(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'coordinates': '{longitude: $_longitude, latitude: $_latitude}',
          'name': _name,
          'brand': _brand
        },
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      return await response;
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return await (e.response);
    }
  }

  /////////
}
