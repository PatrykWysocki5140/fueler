// ignore: file_names
import 'dart:developer' as dev;
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:fueler/model/API_Model/User.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/API_Model/Api_service.dart';

class Api with ChangeNotifier {
  List<User> users = List.empty();
  User user = User();
  ApiService api = ApiService();
  bool loading = false;
  bool savedUser = false;

  // ignore: non_constant_identifier_names
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
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("UserID", "null");
    });
    notifyListeners();
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
}
