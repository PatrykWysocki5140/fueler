// ignore: file_names
import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:fueler/model/API_Model/Brand.dart';
import 'package:fueler/model/API_Model/Coordinates.dart';
import 'package:fueler/model/API_Model/FuelStation.dart';
import 'package:fueler/model/API_Model/SearchParams.dart';
import 'package:fueler/model/API_Model/User.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/API_Model/Api_service.dart';
import 'package:http/http.dart' as http;

class GoogleMaps with ChangeNotifier {
  String baseUrl = "http://fueler.data.awrzawinski.xyz";
  String preferencesKeyToken = "token";
  String preferencesKeyNightMode = "dark_mode_enabled";
  String preferencesKeyDistance = "distance";
  String preferencesKeyuserlat = "userlat";
  String preferencesKeyuserlng = "userlng";
  late double distance;
  String mapTheme = "";
  late bool isDarkTheme;
  String mapApiKey = "AIzaSyBgTRaSwoKFHa5-pFg6JJOgR5VPw6Cb8Ds";
  late double userlat;
  late double userlng;
  List<FuelStation> searchFuelStations = List.empty(growable: true);
  List<FuelStation> allFuelStations = List.empty(growable: true);
  List<Brand> brands = List.empty(growable: true);

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

  Future<bool> setPosition(String _lat, String _lng) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(preferencesKeyuserlat, _lat);
    await prefs.setString(preferencesKeyuserlng, _lng);
    getPosition();
    return true;
  }

  Future<LatLng> getPosition() async {
    var prefs = await SharedPreferences.getInstance();
    userlat = await double.parse(prefs.getString(preferencesKeyuserlat)!);
    userlng = await double.parse(prefs.getString(preferencesKeyuserlng)!);
    LatLng position = LatLng(userlat, userlng);
    return position;
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

    final url = '$_host?latlng=$lat,$lng&key=$mapApiKey';
    if (lat != null && lng != null) {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String _formattedAddress = "";
        if ((data.isNotEmpty) ||
            (data["results"][0] != null) ||
            (data["results"] == List.empty()) ||
            (data["results"][0]["formatted_address"] != null)) {
          if (data["status"] != "OVER_QUERY_LIMIT") {
            _formattedAddress = data["results"][0]["formatted_address"];
          }
        }
        log("Adres: $_formattedAddress");
        return _formattedAddress;
      } else
        return null;
    } else
      return null;
  }

  Future<String> getBrand(String _brand, String valuetoSearch) async {
    Brand _b = Brand();

    _b = await getBrandById(valuetoSearch);

    if (_b.image != null) {
      _brand = _b.image;
    } else {
      _brand = _brand.toLowerCase();
    }
    String val = "";

    if (_brand == "orlen") {
      val = 'assets/stationslogo/Orlen.png';
    } else if (_brand == "lotos") {
      val = 'assets/stationslogo/Lotos.png';
    } else if (_brand == "shell") {
      val = 'assets/stationslogo/Shell.png';
    } else if (_brand == "bp") {
      val = 'assets/stationslogo/BP.png';
    } else if (_brand == "intermarche") {
      val = 'assets/stationslogo/InterMarche.png';
    } else if (_brand == "circlek") {
      val = 'assets/stationslogo/CircleK.png';
    } else if (_brand == "auchan") {
      val = 'assets/stationslogo/Auchan.png';
    } else if (_brand == "amic") {
      val = 'assets/stationslogo/Amic.png';
    } else if (_brand == "huzar") {
      val = 'assets/stationslogo/Huzar.png';
    } else if (_brand == "moya") {
      val = 'assets/stationslogo/Moya.png';
    } else if (_brand == "statoil") {
      val = 'assets/stationslogo/Statoil.png';
    } else {
      val = 'assets/stationslogo/default.png';
    }
    return val;
  }

  Future<Response?> getFuelStation(String _distance) async {
    Response response;
    String url = '$baseUrl/api/fuel-stations/location';
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(preferencesKeyToken);

    await getDistance();
    log("distance: " + _distance.toString());
    log("userlng: " + userlng.toString());
    log("userlat: " + userlat.toString());
    final queryParameters = {
      'Coordinates.Longitude': userlng,
      'Coordinates.Latitude': userlat,
      'Distance': _distance,
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
        searchFuelStations.clear();
        List<FuelStation> _model =
            fuelStationModelFromJson(response.data.toString());
        log("getFuelStation lenght:" + _model.length.toString());
        for (var obj in _model) {
          log("getFuelStation:" + obj.toJsonAll().toString());
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
    String? token = await prefs.getString(preferencesKeyToken);

    Coordinates coordinates = Coordinates(
        longitude: double.parse(_longitude), latitude: double.parse(_latitude));
    try {
      log(url);
      response = await dio.post(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'coordinates': coordinates.toJson(),
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

  Future<Response?> addPriceEntry(
      FuelStation _fuelStation, String _fuelType, String _price) async {
    Response response;
    String url = '$baseUrl/api/fuel-stations/${_fuelStation.id}/price-entry';
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString(preferencesKeyToken);

    try {
      log(url);
      response = await dio.post(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'price': _price,
          'fuelType': _fuelType,
          'fuelStation': _fuelStation.id,
        },
      );
      log("status:" + response.statusCode.toString());
      return await response;
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return await (e.response);
    }
  }

  ////////////////////////////////////////////////////////////////////////
  /// Admin
  /// ////////////////////////////////////////////////////////////////

  Future<Response?> getAllFuelStation() async {
    Response response;
    String url = '$baseUrl/api/fuel-stations';
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(preferencesKeyToken);

    try {
      log(url);
      response = await dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 200) {
        List<FuelStation> _model =
            fuelStationModelFromJson(response.data.toString());
        allFuelStations.clear();
        log("AllFuelStation:" + _model.length.toString());
        for (var obj in _model) {
          allFuelStations.add(obj);
          log("AllFuelStation:" + obj.toJson().toString());
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

  Future<FuelStation?> getFuelStationById(String _uId) async {
    FuelStation _f = FuelStation();
    Response response;
    String url = '$baseUrl/api/fuel-stations/$_uId';
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(preferencesKeyToken);

    await getDistance();

    try {
      log(url);
      response = await dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 200) {
        _f = FuelStation.fromJsonNotMapString(await response.data.toString());
        dio.close();
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
    }
    return _f;
  }

  Future<bool?> deleteStationById(String _uId) async {
    Response response;
    String url = '$baseUrl/api/fuel-stations/$_uId';
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(preferencesKeyToken);

    await getDistance();

    try {
      log(url);
      response = await dio.delete(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 204) {
        log(response.data.toString());
        dio.close();
        return true;
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return false;
    }
  }

  Future<Response?> updateStationById(String _uId, String _longitude,
      String _latitude, String _name, String _brand) async {
    Response response;
    String url = '$baseUrl/api/fuel-stations/$_uId';
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString(preferencesKeyToken);

    Coordinates coordinates = Coordinates(
        latitude: double.parse(_latitude), longitude: double.parse(_longitude));
    try {
      log(url);
      response = await dio.put(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'coordinates': coordinates.toJson(),
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

  ////////////////////////////////////////////////////////////////////////
  /// Brand
  /// ////////////////////////////////////////////////////////////////

  Future<Response?> getAllBrands() async {
    Response response;
    String url = '$baseUrl/api/brands';
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(preferencesKeyToken);

    try {
      log(url);
      response = await dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 200) {
        List<Brand> _model = brandModelFromJson(response.data.toString());
        brands.clear();
        for (var obj in _model) {
          brands.add(obj);
          log("Brand:" + obj.toJson().toString());
        }
        if (_model.isNotEmpty) brands = _model;
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

  Future<Brand> getBrandById(String _uId) async {
    Brand _b = Brand();
    Response response;
    String url = '$baseUrl/api/brands/$_uId';
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(preferencesKeyToken);

    try {
      log(url);
      response = await dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 200) {
        _b = Brand.fromJsonNotMapString(await response.data.toString());
        //_b.setImage('assets/stationslogo/Orlen.png');
        dio.close();
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
    }
    return _b;
  }

  Future<Response?> addbrand(String _name, String _image) async {
    Response response;
    String url = '$baseUrl/api/brands';
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString(preferencesKeyToken);

    try {
      log(url);
      response = await dio.post(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {"Name": _name, "Image": _image},
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

  Future<Response?> updateBrandById(
      String _uId, String _name, String _image) async {
    Response response;
    String url = '$baseUrl/api/brands/$_uId';
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString(preferencesKeyToken);

    try {
      log(url);
      response = await dio.put(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {"Name": _name, "Image": _image},
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

  Future<bool?> deleteBrandById(String _uId) async {
    Response response;
    String url = '$baseUrl/api/brands/$_uId';
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(preferencesKeyToken);

    try {
      log(url);
      response = await dio.delete(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 204) {
        log(response.data.toString());
        dio.close();
        return true;
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return false;
    }
  }
  ////////////////////////////////////////////////////////////////////////
  /// Best Station
  /// ////////////////////////////////////////////////////////////////

  Future<Response?> getBestFuelStation(SearchParams _params) async {
    FuelStation _f = FuelStation();
    Response response;
    String url = 'http://fueler.computation.awrzawinski.xyz/api/best-station/';
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(preferencesKeyToken);

    final queryParameters = {
      'Coordinates.Longitude': _params.coordinates.longitude,
      'Coordinates.Latitude': _params.coordinates.latitude,
      'Distance': _params.distance,
      'FuelType': _params.fuelType,
      'amount': _params.amount,
      'burnRate': _params.burnRate,
      'searchType': _params.searchType,
    };
    try {
      log(url);
      log(queryParameters.toString());
      response = await dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        queryParameters: queryParameters,
      );

      log("status:" + response.statusCode.toString());
      if ((response.statusCode == 200) || (response.statusCode == 204)) {
        dio.close();
        return response;
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return e.response;
    }
  }
}
