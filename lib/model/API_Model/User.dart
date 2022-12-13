import "dart:convert";
import 'dart:developer';
import 'package:fueler/model/API_Model/MyJson.dart';

import "UserPrivilegeLevel.dart";
import 'dart:convert';

MyJson myjson = MyJson();
/*
List<User> userModelFromJson(String str) =>
    List<User>.from(json.decode(str)((x) => User.fromJson(x)));
*/

String userModelToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<User> userModelFromJson(String str) {
  String _json = myjson.JsonDecoder(str);
  _json = myjson.JsonDecoderList(_json);
  List<dynamic> parsedListJson = jsonDecode(_json) as List;
  List<User> itemsList = List<User>.from(
      parsedListJson.map<User>((dynamic i) => User.fromJsonList(i)));
  return itemsList;
}

class User {
  User({
    id,
    name,
    password,
    phoneNumber,
    email,
    created,
    isConfirmed,
    isBanned,
    userPrivilegeLevel,
  });
  String? id;
  String? name; //
  String? email; //
  String? password; //
  String? phoneNumber; //
  DateTime? created;
  bool? isConfirmed;
  bool? isBanned;
  UserPrivilegeLevel? userPrivilegeLevel;

  void SetValues(
      String _id,
      String _name,
      String _password,
      String _phoneNumber,
      String _email,
      DateTime? _created,
      bool? _isConfirmed,
      bool? _isBanned,
      UserPrivilegeLevel? _userPrivilegeLevel) {
    id = _id;
    name = _name;
    password = _password;
    phoneNumber = _phoneNumber;
    email = _email;
    created = _created;
    isConfirmed = _isConfirmed;
    isBanned = _isBanned;
    userPrivilegeLevel = _userPrivilegeLevel;
  }

  // ignore: non_constant_identifier_names
  void SetNewPassword(
    String _password,
  ) {
    password = _password;
  }

  // ignore: non_constant_identifier_names
  void SetNewEmail(
    String _email,
  ) {
    email = _email;
  }

  // ignore: non_constant_identifier_names
  void SetNewPhoneNumber(
    String _phonenumber,
  ) {
    phoneNumber = _phonenumber;
  }

  void SetNewName(
    String _name,
  ) {
    name = _name;
  }

  void SetConfirm(
    bool _isConfirmed,
  ) {
    isConfirmed = _isConfirmed;
  }

  void SetBann(
    bool _isBanned,
  ) {
    isBanned = _isBanned;
  }

  // ignore: non_constant_identifier_names
  void Clear() {
    id = null;
    name = null;
    password = null;
    phoneNumber = null;
    email = null;
    created = null;
    isConfirmed = null;
    isBanned = null;
    userPrivilegeLevel = null;
  }

  factory User.fromJson(dynamic myJSON) {
    //String xyz = myjson.JsonDecoder(myJSON);
    User _user = User();

    String result = myjson.JsonDecoder(myJSON.toString());
    //result ="{\"userName\": \"Dawid\", \"phoneNumber\": \"1234567890\", \"email\": \"test@test.com\", \"isConfirmed\": \"false\", \"isBanned\": \"false\", \"userPrivilegeLevel\": \"USER\"}";
    log("JsonEncoder:" + result.toString());
    final jsondecode = json.decode(result.toString());
    log("User.fromJson:" + json.toString());
    log("json[userPrivilegeLevel].toString():" +
        jsondecode['userPrivilegeLevel'].toString());

    UserPrivilegeLevel _up = _user
        .getUserPrivilegeLevel(jsondecode['userPrivilegeLevel'].toString());

    //int _id = int.parse(jsondecode["id"] ?? 1.toString());

    _user.SetValues(
        jsondecode["id"],
        jsondecode["userName"] ?? jsondecode["name"],
        jsondecode["password"] ?? "yourpassword123",
        jsondecode["phoneNumber"],
        jsondecode["email"],
        jsondecode["created"] == "null"
            ? DateTime.parse('1969-07-20 20:18:04Z')
            : jsondecode["created"],
        jsondecode["isConfirmed"] == "false" ? false : true,
        jsondecode["isBanned"] == "false" ? false : true,
        _up);

    log("User from JSON: ${_user.id} ${_user.name} ${_user.email} ${_user.phoneNumber}");
    return _user;
  }

  factory User.fromJsonList(dynamic data) {
    Map<String, dynamic> json = Map<String, dynamic>.from(data);
    User _user = User();

    UserPrivilegeLevel _up =
        _user.getUserPrivilegeLevel(json['userPrivilegeLevel'].toString());

    //int _id = int.parse(json["id"] ?? 1.toString());

    _user.SetValues(
        json["id"],
        json["userName"] ?? json["name"],
        json["password"] ?? "yourpassword123",
        json["phoneNumber"],
        json["email"],
        json["created"] == "null"
            ? DateTime.parse('1969-07-20 20:18:04Z')
            : json["created"],
        json["isConfirmed"] == "false" ? false : true,
        json["isBanned"] == "false" ? false : true,
        _up);
    log("User from JSON: ${_user.id} ${_user.name} ${_user.email} ${_user.phoneNumber}");
    return _user;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "password": password,
        "phoneNumber": phoneNumber,
        "email": email,
        "created": created,
        "isConfirmed": isConfirmed,
        "isBanned": isBanned,
        "userPrivilegeLevel": userPrivilegeLevel,
      };

  //setVal(int _id) => {this.id = _id};

  UserPrivilegeLevel getUserPrivilegeLevel(String up) {
    UserPrivilegeLevel _up = UserPrivilegeLevel.USER;
    if ((up == "ADMINISTRATOR") || (up == "UserPrivilegeLevel.ADMINISTRATOR")) {
      _up = UserPrivilegeLevel.ADMINISTRATOR;
    } else if ((up == "VERIFIED_USER") ||
        (up == "UserPrivilegeLevel.VERIFIED_USER")) {
      _up = UserPrivilegeLevel.VERIFIED_USER;
    } else if ((up == "USER") || (up == "UserPrivilegeLevel.USER")) {
      _up = UserPrivilegeLevel.USER;
    } else {
      _up = UserPrivilegeLevel.UNDEFINED;
    }

    return _up;
  }

  void setUserPrivilegeLevel(String up) {
    UserPrivilegeLevel _up = UserPrivilegeLevel.USER;
    if ((up == "ADMINISTRATOR") || (up == "UserPrivilegeLevel.ADMINISTRATOR")) {
      _up = UserPrivilegeLevel.ADMINISTRATOR;
    } else if ((up == "VERIFIED_USER") ||
        (up == "UserPrivilegeLevel.VERIFIED_USER")) {
      _up = UserPrivilegeLevel.VERIFIED_USER;
    } else if ((up == "USER") || (up == "UserPrivilegeLevel.USER")) {
      _up = UserPrivilegeLevel.USER;
    } else {
      _up = UserPrivilegeLevel.UNDEFINED;
    }

    userPrivilegeLevel = _up;
  }
}
