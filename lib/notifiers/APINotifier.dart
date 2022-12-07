// ignore: file_names
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:fueler/model/API_Model/User.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/API_Model/Api_service.dart';

class Api with ChangeNotifier {
  String baseUrl = "http://fueler.data.awrzawinski.xyz";
  String preferencesKeyToken = "token";
  String preferencesKeyUser = "userData";
  User user = User();

  ////
  List<User> users = List.empty();
  ApiService api = ApiService();
  bool loading = false;
  bool savedUser = false;
  String? token = null;

  // ignore: non_constant_identifier_names
  Future<dynamic> GetLocalUser() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(preferencesKeyUser);

    if (jsonString == null) {
      if (user.id != null) {
        user.Clear();
      }
    } else {
      log("SharedPreferences save user: " + jsonString);
      user = User.fromJson(jsonString);
    }
  }

  /*
  Future<dynamic> GetLocalUser() async {
    dynamic val;
    SharedPreferences.getInstance().then((prefs) async {
      if (prefs.getString("UserID") != null) {
        if (prefs.getString("UserID")!.isNotEmpty == true) {
          if (prefs.getString("UserID").toString() != "null") {
            val = prefs.getString("UserID");
          } else {
            val = 0;
          }
        } else {
          val = 0;
        }
      } else {
        val = 0;
      }
      dev.log("Class-API //GetLocalUser// Local UserID:" +
          val.toString() +
          "  prefs.getString(\"UserID\"): " +
          prefs.getString("UserID").toString());
      user = (await api.apiService_getUserById(int.parse(val.toString())))!;
      if (user.id != null) SaveLocalUser(user);
    });
  }
*/
  // ignore: non_constant_identifier_names
  void SaveLocalUser(User u) {
    //users.add(u);
    savedUser = true;
    user = u;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("UserID", u.id.toString());
    });
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  Users(context) async {
    loading = true;
    users = (await api.apiService_getUsers(context))!;
    loading = false;
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  Future<User?> LogIn(String login, String password) async {
    User? _user = (await api.apiService_loginUser(login, password));
    if (_user?.id != null) SaveLocalUser(_user!);

    return _user;
  }

  Future<bool> LogOut() async {
    user.Clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(preferencesKeyUser);
    prefs.remove(preferencesKeyToken);
    return true;
  }

  /*
  Future<bool> LogOut() async {
    user.Clear();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("UserID", "null");
    });
    notifyListeners();
    return true;
  }
*/
  Future<bool> DeleteAllPreferences() async {
    user.Clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }

  Future<User?> RegisterUser(User user) async {
    User? _user = (await api.apiService_registerUser(user.toJson()));
    if (_user?.id != null) SaveLocalUser(_user!);

    return _user;
  }

  Future<User?> UpdateUser(User user, context) async {
    User? _user = (await api.apiService_updateUser(user.toJson()));
    log("UpdateUser wejscie " + user.toJson().toString());
    if (_user?.id != null) {
      Provider.of<Api>(context, listen: false)
          .user
          .SetNewPassword(user.password.toString());
      //user.SetNewPassword(user.password.toString());
      SaveLocalUser(_user!);
    }
    log("UpdateUser wyjscie " + _user!.toJson().toString());

    return _user;
  }

/////////////////////////////////////////////////////////////////////

  Future<User?> notifierLogInUser(String login, String password) async {
    User? user;
    token = (await api.getUserToken(login, password));
    user = (await api.getLoginUserData(token!));
    if ((token!.isNotEmpty) && (user != null)) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString(preferencesKeyToken, token!);
        prefs.setString(preferencesKeyUser, user!.toJson().toString());
      });
      notifyListeners();
    }
    return user;
  }

  Future<User?> login(String username, String password) async {
    // Utwórz obiekt Dio z konfiguracją
    var dio = Dio();
    User _user = User();

    // Utwórz adres URL do logowania użytkownika z parametrami zapytania
    var url = '$baseUrl/api/users/login?name=$username&password=$password';

    log(url);
    try {
      // Wyślij żądanie HTTP GET do adresu URL
      var response = await dio.get(url);

      // Pobierz token z odpowiedzi
      var token = response.data;
      log("token:" + token);
      // Zapisz token w SharedPreferences
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString(preferencesKeyToken, token);

      // Jeśli status 200 i token różny od null
      if ((response.statusCode == 200) && (token != null)) {
        Future<String?> _userFromJson = getMyData();
        // ignore: unrelated_type_equality_checks
        if (_userFromJson != "") {
          _user = await User.fromJson(await _userFromJson);
          await prefs.setString(preferencesKeyUser, _user.toJson().toString());
          user = _user;
          return _user;
        }
        //Zwracanie pobranego usera
      }
    } catch (e) {
      // Jeśli wystąpi błąd, zwróć pustego usera
      return _user;
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
      return "";
    }
    log("status:" + response.statusCode.toString());
    // Pobierz dane użytkownika z odpowiedzi
    if (response.statusCode == 200) {
      log("response.data: " + response.data.toString());
      return await response.data.toString();
    } else {
      log("empty");
      // Jeśli status inny niż 200, zwróć pusty
      return "";
    }
  }
}
