// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:fueler/model/API_Model/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/API_Model/Api_service.dart';

class Api with ChangeNotifier {
  late List<User> users;
  ApiService api = ApiService();
  bool loading = false;

  // ignore: non_constant_identifier_names
  Users(context) async {
    loading = true;
    users = (await api.getUsers(context))!;
    loading = false;

    notifyListeners();
  }
}
