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

class Api with ChangeNotifier {
  String baseUrl = "http://fueler.data.awrzawinski.xyz";
  String preferencesKeyToken = "token";
  String preferencesKeyUser = "userData";
  String preferencesKeyUserExist = "userExist";
  User user = User();
  PriceEntries priceEntry = PriceEntries();
  String token = "";
  List<User> users = List.empty();
  List<PriceEntries> mePriceEntries = List.empty();
  List<PriceEntries> searchpriceEntrie = List.empty();
  bool userExist = false;

  ////
  ApiService api = ApiService();
  bool savedUser = false;
  bool loading = false;

  // ignore: non_constant_identifier_names
  Future<dynamic> GetLocalUser() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(preferencesKeyUser);
    final _token = prefs.getString(preferencesKeyToken);
    final _userExist = prefs.getString(preferencesKeyUserExist);
    if (_userExist == "true") {
      userExist = true;
    }
    log(" userExist: " + userExist.toString());
    if (jsonString == null) {
      if (user.id != null) {
        user.Clear();
      }
    } else {
      token = _token!;
      if (_userExist == "true") {
        userExist = true;
      }
      log("SharedPreferences save user: " + jsonString + " token: " + token);
      user = User.fromJson(jsonString);
      if (user.userPrivilegeLevel == UserPrivilegeLevel.ADMINISTRATOR) {
        await getAllUsers();
      }
    }
  }

  Future<bool> LogOut() async {
    user.Clear();
    token = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(preferencesKeyUser);
    prefs.remove(preferencesKeyToken);
    return true;
  }

  Future<bool> DeleteAllPreferences() async {
    user.Clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }

  Future<Response?> registerUser(String _name, String _phoneNumber,
      String _email, String _password) async {
    Response response;
    String url = '$baseUrl/api/users';
    Dio dio = Dio();

    try {
      log(url);

      log('userName:' +
          _name +
          ' phoneNumber:' +
          _phoneNumber +
          ' password:' +
          _password +
          ' email:' +
          _email +
          " token: " +
          token);
      response = await dio.post(
        url,
        //options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'userName': _name,
          'password': _password,
          'phoneNumber': _phoneNumber,
          'email': _email,
        },
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 204) {
        if (user.userPrivilegeLevel != UserPrivilegeLevel.ADMINISTRATOR) {
          await login(_name, _password);
        }
        dio.close();
        return await response;
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return await (e.response);
    }
  }

  Future<Response?> updatePassword(
      String _currentPassword, String _newPassword, context) async {
    Response response;
    String url = '$baseUrl/api/users/me/password';
    Dio dio = Dio();

    try {
      log(url);
      // Dodaj token do nagłówka autoryzacji

      log("_currentPassword:" +
          _currentPassword +
          " _newPassword:" +
          _newPassword +
          " token: " +
          token);
      // Zaktualizuj dane użytkownika za pomocą metody PUT na adresie /api/users/me/password
      response = await dio.put(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'currentPassword': _currentPassword,
          'newPassword': _newPassword,
        },
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 204) {
        dio.close();
        return await response;
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return await (e.response);
    }
    log("status:" + response.statusCode.toString());
    if (response.statusCode == 204) {
      dio.close();
      return await response;
    } else {
      dio.close();
      return await response;
    }
  }

  Future<Response?> deleteUser(context) async {
    Response response;
    String url = '$baseUrl/api/users/me';
    Dio dio = Dio();

    try {
      log(url);
      // Dodaj token do nagłówka autoryzacji

      log(" token: " + token);
      // Zaktualizuj dane użytkownika za pomocą metody PUT na adresie /api/users/me/password
      response = await dio.delete(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 204) {
        log("User deleted");
        dio.close();
        LogOut();
        return await response;
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return await (e.response);
    }
    log("status:" + response.statusCode.toString());
    if (response.statusCode == 204) {
      dio.close();
      LogOut();
      return await response;
    } else {
      dio.close();
      return await response;
    }
  }

  Future<Response?> updateUserData(
      String _name, String _phoneNumber, String _email, context) async {
    Response response;
    String url = '$baseUrl/api/users/me';
    Dio dio = Dio();

    try {
      log(url);
      // Dodaj token do nagłówka autoryzacji

      log('userName:' +
          _name +
          ' phoneNumber:' +
          _phoneNumber +
          ' email:' +
          _email +
          " token: " +
          token);
      // Zaktualizuj dane użytkownika za pomocą metody PUT na adresie /api/users/me/password
      response = await dio.put(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'userName': _name,
          'phoneNumber': _phoneNumber,
          'email': _email,
        },
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 204) {
        user.SetNewEmail(_email);
        user.SetNewName(_name);
        user.SetNewPhoneNumber(_phoneNumber);
        dio.close();
        return await response;
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return await (e.response);
    }

    log("status:" + response.statusCode.toString());
    if (response.statusCode == 204) {
      user.SetNewEmail(_email);
      user.SetNewName(_name);
      user.SetNewPhoneNumber(_phoneNumber);
      dio.close();
      return await response;
    } else {
      dio.close();
      return await response;
    }
  }

  Future<Response?> login(String username, String password) async {
    // Utwórz obiekt Dio z konfiguracją
    var dio = Dio();
    User _user = User();

    // Utwórz adres URL do logowania użytkownika z parametrami zapytania
    var url = '$baseUrl/api/users/login?name=$username&password=$password';

    try {
      log(url);
      // Wyślij żądanie HTTP GET do adresu URL
      Response response = await dio.get(url);
      if (response.statusCode != 401) {
        // Pobierz token z odpowiedzi
        var _token = response.data;
        log("token:" + token);

        // Jeśli status 200 i token różny od null
        if ((response.statusCode == 200) && (_token != null)) {
          // Zapisz token w SharedPreferences
          var prefs = await SharedPreferences.getInstance();
          await prefs.setString(preferencesKeyToken, _token);

          Future<String?> _userFromJson = getMyData();
          // ignore: unrelated_type_equality_checks
          if (_userFromJson != "") {
            _user = await User.fromJson(await _userFromJson);
            await prefs.setString(
                preferencesKeyUser, _user.toJson().toString());
            await prefs.setString(preferencesKeyUserExist, true.toString());
            token = _token;
            user = _user;
            dio.close();
            return response;
          }
          //Zwracanie pobranego usera
        } else {
          dio.close();
          return response;
        }
      } else {
        dio.close();
        return response;
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      // Jeśli wystąpi błąd, zwróć pustego usera
      return e.response;
    }
  }

  Future<String?> getMyData() async {
    // Pobierz token z SharedPreferences
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(preferencesKeyToken);

    // Utwórz obiekt Dio z konfiguracją
    var dio = Dio();

    // Utwórz adres URL do pobierania własnych danych użytkownika
    String url = '$baseUrl/api/users/me';
    log("wejście: " + url);
    Response response;
    try {
      // Wyślij żądanie HTTP GET do adresu URL z nagłówkiem autoryzacyjnym
      response = await dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioError catch (e) {
      // Jeśli wystąpi błąd, zwróć pusty
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return "";
    }
    log("status:" + response.statusCode.toString());
    // Pobierz dane użytkownika z odpowiedzi
    if (response.statusCode == 200) {
      log("response.data: " + response.data.toString());
      dio.close();
      return await response.data.toString();
    } else {
      log("empty");
      dio.close();
      // Jeśli status inny niż 200, zwróć pusty
      return "";
    }
  }

  Future<Response?> getMyPriceEntries() async {
    Response response;
    String url = '$baseUrl/api/users/me/price-entries';
    Dio dio = Dio();

    try {
      log(url);
      response = await dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 200) {
        List<PriceEntries> _model =
            priceEntriesModelFromJson(response.data.toString());
        for (var obj in _model) {
          log("PriceEntries:" + obj.toJson().toString());
        }
        if (_model.isNotEmpty) mePriceEntries = _model;
        dio.close();
        return await response;
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return await (e.response);
    }
  }

///////////////////////////////////////////////////////////
  ///ADMIN
///////////////////////////////////////////////////////////
  ///
  ///

  Future<Response?> getAllUsers() async {
    Response response;
    String url = '$baseUrl/api/users';
    Dio dio = Dio();

    try {
      log(url);
      response = await dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 200) {
        List<User> _model = userModelFromJson(response.data.toString());
        for (var obj in _model) {
          log(obj.toJson().toString());
        }
        if (_model.isNotEmpty) users = _model;
        dio.close();
        return await response;
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return await (e.response);
    }
  }

  Future<Response?> updateUserById(User _user) async {
    Response response;
    String _uId = _user.id.toString();
    ////// test
    ///

    //_uId = "6";

    ///
    String url = '$baseUrl/api/users/$_uId';
    Dio dio = Dio();

    try {
      log(url);
      response = await dio.put(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'userName': _user.name,
          'phoneNumber': _user.phoneNumber,
          'email': _user.email,
          'created': _user.created,
          'isConfirmed': _user.isConfirmed,
          'isBanned': _user.isBanned,
          'userPrivilegeLevel': _user
              .getUserPrivilegeLevel(_user.userPrivilegeLevel.toString())
              .name
        },
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 204) {
        dio.close();
        return await response;
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return await (e.response);
    }
  }

  Future<User?> getUserById(String _uId) async {
    User _user = User();
    Response response;
    String url = '$baseUrl/api/users/$_uId';
    Dio dio = Dio();

    try {
      log(url);
      response = await dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 200) {
        _user = User.fromJson(await response.data);
        dio.close();
        // return response.data;
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      //return e.response;
    }
    return _user;
  }

  Future<Response?> deleteUserById(User _user) async {
    Response response;
    String _uId = _user.id.toString();
    ////// test
    ///

    //_uId = "2";

    ///
    String url = '$baseUrl/api/users/$_uId';
    Dio dio = Dio();

    try {
      log(url);
      response = await dio.delete(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'userName': _user.name,
          'phoneNumber': _user.phoneNumber,
          'email': _user.email,
          'created': _user.created,
          'isConfirmed': _user.isConfirmed,
          'isBanned': _user.isBanned,
          'userPrivilegeLevel': _user
              .getUserPrivilegeLevel(_user.userPrivilegeLevel.toString())
              .name
        },
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 204) {
        dio.close();
        return await response;
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return await (e.response);
    }
  }

  Future<Response?> getPriceEntriesByUserId(String _uId) async {
    Response response;
    String url = '$baseUrl/api/users/$_uId/price-entries';
    Dio dio = Dio();

    try {
      log(url);
      response = await dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // Wyświetl odpowiedź
      log("status:" + response.statusCode.toString());
      if (response.statusCode == 200) {
        List<PriceEntries> _model =
            priceEntriesModelFromJson(response.data.toString());
        for (var obj in _model) {
          log("PriceEntriesById:" + obj.toJson().toString());
        }
        if (_model.isNotEmpty) {
          searchpriceEntrie = _model;
        } else {
          searchpriceEntrie = List.empty();
        }
        dio.close();
        return await response;
      }
    } on DioError catch (e) {
      log("e.response!.data: " + e.response!.data.toString());
      dio.close();
      return await (e.response);
    }
  }
}
