import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../model/enums/classes/user.dart';
import '../settings/constants.dart';

class AuthModel extends ChangeNotifier {
  String errorMessage = "";

  bool _rememberMe = false;
  bool _stayLoggedIn = true;
  late User _user;

  bool get rememberMe => _rememberMe;

  void handleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("remember_me", value);
    });
  }

  bool get stayLoggedIn => _stayLoggedIn;

  void handleStayLoggedIn(bool value) {
    _stayLoggedIn = value;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("stay_logged_in", value);
    });
  }

  void loadSettings() async {
    var _prefs = await SharedPreferences.getInstance();
    try {
      _rememberMe = _prefs.getBool("remember_me") ?? false;
    } catch (e) {
      log(e.toString());
      _rememberMe = false;
    }
    try {
      _stayLoggedIn = _prefs.getBool("stay_logged_in") ?? false;
    } catch (e) {
      log(e.toString());
      _stayLoggedIn = false;
    }

    if (_stayLoggedIn) {
      try {
        String? _saved = _prefs.getString("user_data");
        log("Saved: $_saved");
        _user = User.fromJson(json.decode(_saved!));
      } catch (e) {
        log("User Not Found: $e");
      }
    }
    notifyListeners();
  }

  User get user => _user;

  Future<User?> getInfo(int id) async {
    try {
      var _data = await http.get(apiURL as Uri);
      // var _json = json.decode(json.encode(_data));
      var _newUser = User.fromJson(json.decode(_data.body)["data"]);
      _newUser.id = id;
      return _newUser;
    } catch (e) {
      log("Could Not Load Data: $e");
      return null;
    }
  }

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    //var uuid = const Uuid();
    String _username = username;
    String _password = password;
    int id;

    // TODO: API LOGIN CODE HERE
    //return id
    id = 0; //sample

    await Future.delayed(Duration(seconds: 3));
    log("Logging In => $_username, $_password");

    if (_rememberMe) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString("saved_username", _username);
      });
    }

    // Get Info For User
    User? _newUser = await getInfo(id); //(uuid.v4().toString());
    if (_newUser != null) {
      _user = _newUser;
      notifyListeners();

      SharedPreferences.getInstance().then((prefs) {
        var _save = json.encode(_user.toJson());

        log("Data: $_save");
        prefs.setString("user_data", _save);
      });
      return true;
    } else {
      return false;
    }

    //if (_newUser!.token.isEmpty) return false;
  }

  Future<void> logout() async {
    _user = null as User;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("user_data", null as String);
    });
    return;
  }
}
