// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:fueler/model/API_Model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/API_Model/Api_service.dart';

class Api with ChangeNotifier {
  late List<User> users;
  User user = User();
  ApiService api = ApiService();
  bool loading = false;
  bool savedUser = false;

  // ignore: non_constant_identifier_names
  Future<dynamic> GetLocalUser() async {
    var _prefs = await SharedPreferences.getInstance();
    user =
        (await api.apiService_getUserById(_prefs.getString("UserID") as int))!;
    if (user.id != null) SaveLocalUser(user);
    return user;
  }

  // ignore: non_constant_identifier_names
  void SaveLocalUser(User u) {
    users.add(u);
    savedUser = true;
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

  Future<dynamic> LogIn(String login, String password) async {
    user = (await api.apiService_loginUser(login, password))!;
    if (user == null) {
      return null;
    } else {
      SaveLocalUser(user);
    }
  }

  Future<User?> RegisterUser(User user) async {
    user = (await api.apiService_registerUser(user.toJson()))!;
    if (user != null) SaveLocalUser(user);

    return user;
  }
}
