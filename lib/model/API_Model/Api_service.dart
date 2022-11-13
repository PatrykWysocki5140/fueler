import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fueler/model/API_Model/User.dart';
import 'package:fueler/settings/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ///////////////////////// http
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

  Future<User?> register(User user) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndpoint),
          body: {
            'login': login,
          });

      if (response.statusCode == 200) {
        List<User> _model = userModelFromJson(response.body);
        return _model.first;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  ///////////////////////// dio
  final Dio _dio = Dio();

  Future<dynamic> registerUser(Map<String, dynamic>? data) async {
    Response response;
    try {
      response = await _dio.post(
          ApiConstants.baseUrl + ApiConstants.userEndpoint,
          data: data,
          queryParameters: {'apikey': ApiConstants.apiKey},
          options: Options(headers: {}));
      //return User.fromJson(response.data);
    } on DioError catch (e) {
      //return e.response!.data;
      response = e.response!.data;
    }
    return User.fromJson(response.data);
  }

  Future<dynamic> loginUser(String login, String password) async {
    try {
      Response response = await _dio.post(
        ApiConstants.baseUrl + ApiConstants.userEndpoint,
        data: {
          'login': login,
          'password': password,
        },
        queryParameters: {'apikey': ApiConstants.apiKey},
      );
      return User.fromJson(response.data);
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> getUserProfileData(String accessToken) async {
    try {
      Response response = await _dio.get(
        ApiConstants.baseUrl + ApiConstants.userEndpoint,
        queryParameters: {'apikey': ApiConstants.apiKey},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> updateUserProfile({
    required String accessToken,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await _dio.put(
        ApiConstants.baseUrl + ApiConstants.userEndpoint,
        data: data,
        queryParameters: {'apikey': ApiConstants.apiKey},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> logoutUser(String accessToken) async {
    try {
      Response response = await _dio.get(
        ApiConstants.baseUrl + ApiConstants.userEndpoint,
        queryParameters: {'apikey': ApiConstants.apiKey},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
}
