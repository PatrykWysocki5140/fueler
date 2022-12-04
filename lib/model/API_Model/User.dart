import "dart:convert";
import "UserPrivilegeLevel.dart";

List<User> userModelFromJson(String str) =>
    List<User>.from(json.decode(str)((x) => User.fromJson(x)));

String userModelToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  int? id;
  String? name; //
  String? email; //
  String? password; //
  String? phoneNumber; //
  DateTime? created;
  bool? isConfirmed;
  bool? isBanned;
  UserPrivilegeLevel? userPrivilegeLevel;

  void SetValues(
      int _id,
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

  void SetNewPassword(
    String _password,
  ) {
    password = _password;
  }

  void SetNewEmail(
    String _email,
  ) {
    email = _email;
  }

  void SetNewPhoneNumber(
    String _phonenumber,
  ) {
    phoneNumber = _phonenumber;
  }

  factory User.fromJson(dynamic json) {
    User _user = User();
    _user.SetValues(
        json["id"],
        json["name"],
        json["password"],
        json["phoneNumber"],
        json["email"],
        json["created"],
        json["isConfirmed"],
        json["isBanned"],
        UserPrivilegeLevel.values.elementAt(1 /*json["userPrivilegeLevel"]*/));
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

  setVal(int _id) => {this.id = _id};
}
