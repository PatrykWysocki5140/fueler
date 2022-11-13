import 'dart:developer';
import 'package:fueler/model/API_Model/User.dart';
import 'package:fueler/settings/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<User>?> getUsers(context) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<User> _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<User?> login(String login, password) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndpoint),
          body: {'login': login, 'password': password});

      if (response.statusCode == 200) {
        List<User> _model = userModelFromJson(response.body);
        return _model.first;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
