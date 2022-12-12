import 'dart:developer';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:fueler/model/API_Model/User.dart';
import 'package:fueler/settings/constants.dart';
import 'package:http/http.dart' as http;

import 'UserPrivilegeLevel.dart';

class ApiService {
  ///////////////////////// http
  ///

  Future<List<User>?> apiService_getUsers(context) async {
    /*
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
    return null;*/
  }

/*
  Future<User?> apiService_login(String login, password) async {
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

  Future<User?> apiService_register(User user) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndpoint),
          body: {
            'login': user.name,
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
*/
  ///////////////////////// dio
  final Dio _dio = Dio();

  // ignore: non_constant_identifier_names
  Future<dynamic> apiService_registerUser(Map<String, dynamic>? data) async {
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
      response = e.response ??
          Response(
            requestOptions: RequestOptions(
                method: "GET",
                path: ApiConstants.baseUrl + ApiConstants.userEndpoint),
            statusCode: 400,
          );
    }
    return response.statusCode == 200 ? User.fromJson(response.data) : null;
  }

  Future<dynamic> apiService_updateUser(Map<String, dynamic>? data) async {
    /*
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
      response = e.response ??
          Response(
            requestOptions: RequestOptions(
                method: "GET",
                path: ApiConstants.baseUrl + ApiConstants.userEndpoint),
            statusCode: 400,
          );
    }
    return response.statusCode == 200 ? User.fromJson(response.data) : null;
    */
    log(data.toString());
    User _u = User.fromJson(data!);
    log("_U " + _u.toJson().toString());
    return _u;
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> apiService_loginUser(String login, String password) async {
    log(login + " " + password);
    Response response;
    try {
      response = await _dio.post(
        ApiConstants.baseUrl + ApiConstants.userEndpoint,
        data: {
          'login': login,
          'password': password,
        },
        queryParameters: {'apikey': ApiConstants.apiKey},
      );
      //return User.fromJson(response.data);
    } on DioError catch (e) {
      //return e.response!.data;
      response = e.response ??
          Response(
            requestOptions: RequestOptions(
                method: "GET",
                path: ApiConstants.baseUrl + ApiConstants.userEndpoint),
            statusCode: 400,
          );
    }
    return response.statusCode == 200 ? User.fromJson(response.data) : null;
  }

  // ignore: non_constant_identifier_names
  Future<User?> apiService_getUserById(String id) async {
    /*
    //// to jest ok
    try {
      Response response = await _dio.post(
        ApiConstants.baseUrl + ApiConstants.userEndpoint,
        data: {
          'id': id.toString(),
        },
        queryParameters: {'apikey': ApiConstants.apiKey},
      );
      return User.fromJson(response.data);
    } on DioError catch (e) {
      return null;
    }
    ///////
    */

    //testy
    //id = 2;
    User u = User();
    u.SetValues(
        id,
        "test",
        "pass123",
        "123456789",
        "email@wp.pl",
        DateTime.parse('1969-07-20 20:18:04Z'),
        true,
        false,
        UserPrivilegeLevel.USER);
    if (id == 0) u.Clear();
    //u.Clear();
    //log("apiService_getUserById: "+u.id.toString());
    return u;

    ///
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> apiService_getUserProfileData(String accessToken) async {
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

  // ignore: non_constant_identifier_names
  Future<dynamic> apiService_updateUserProfile({
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

  // ignore: non_constant_identifier_names
  Future<dynamic> apiService_logoutUser(String accessToken) async {
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

//////////////////////////////////////////////////////////////////////////// new
  ///
  Future<dynamic> getUserToken(String login, String password) async {
    log("Class: ApiService //apiLoginUser//: " + login + " " + password);
    Response response;
    try {
      response = await _dio.get(
        ApiConstants.baseUrl +
            ApiConstants.userEndpoint +
            ApiConstants.userlogin,
        queryParameters: {'name': login, 'password': password},
      );
    } on DioError catch (e) {
      response = e.response ??
          Response(
            requestOptions: RequestOptions(
                method: "GET",
                path: ApiConstants.baseUrl + ApiConstants.userEndpoint),
            statusCode: 400,
          );
    }
    return response.statusCode == 200 ? response.data : null;
  }

  Future<dynamic> getLoginUserData(String accessToken) async {
    Response response;
    try {
      response = await _dio.get(
        ApiConstants.baseUrl + ApiConstants.userEndpoint + ApiConstants.me,
        queryParameters: {'apikey': ApiConstants.apiKey},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      //return response.data;
    } on DioError catch (e) {
      response = e.response!.data;
    }
    return response.statusCode == 200 ? User.fromJson(response.data) : null;
  }
}
/*
"{"userName": "Dawid", "phoneNumber": "1234567890", "email": "test@test.com", "isConfirmed": "false", "isBanned": "false", "userPrivilegeLevel": "USER"}"
*/