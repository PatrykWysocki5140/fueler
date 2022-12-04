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
      dev.log("//API//GetLocalUser// Local UserID:" + val.toString());
      user = (await api.apiService_getUserById(int.parse(val.toString())))!;
      //dev.log("GetLocalUser"+user.id.toString());
      if (user.id != null) SaveLocalUser(user);

      //prefs.getString("UserID");
    });
/*
    var _prefs = await SharedPreferences.getInstance();   
    user =
        (await api.apiService_getUserById(_prefs.getString("UserID") as int))!;
    if (user.id != null) SaveLocalUser(user);*/
    //return user;
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
