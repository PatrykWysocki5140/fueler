// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:fueler/model/API_Model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/API_Model/Api_service.dart';

class Api with ChangeNotifier {
  late List<User> users;
  late User user;
  ApiService api = ApiService();
  bool loading = false;
  bool savedUser = false;

  // ignore: non_constant_identifier_names
  Users(context) async {
    loading = true;
    users = (await api.getUsers(context))!;
    loading = false;
    notifyListeners();
  }

  Future<dynamic> LogIn(String login, String password) async {
    user = (await api.loginUser(login, password))!;
    if (user == null) {
      return null;
    } else {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString("UserID", user.id.toString());
      });
    }
    notifyListeners();
  }

    Future<dynamic> RegisterUser(User user) async {
    user = (await api.registerUser(user.toJson()))!;
    if (user == null) {
      return null;
    } else {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString("UserID", user.id.toString());
      });
    }
    notifyListeners();
  }
}
