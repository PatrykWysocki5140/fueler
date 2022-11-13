import "dart:convert";
import "UserPrivilegeLevel.dart";

/*
class User {
  final int id;
  final String name;
  final String password;
  final String phoneNumber;
  final String email;
  final DateTime created;
  final bool isConfirmed;
  final bool isBanned;
  final UserPrivilegeLevel userPrivilegeLevel;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.phoneNumber,
    required this.email,
    required this.created,
    required this.isConfirmed,
    required this.isBanned,
    required this.userPrivilegeLevel,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        name: json["name"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        created: json["created"],
        isConfirmed: json["isConfirmed"],
        isBanned: json["isBanned"],
        userPrivilegeLevel: json["userPrivilegeLevel"]);
  }
}
*/

List<User> userModelFromJson(String str) =>
    //List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
    List<User>.from(json.decode(str));

String userModelToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.id,
    required this.name,
    required this.password,
    required this.phoneNumber,
    required this.email,
    required this.created,
    required this.isConfirmed,
    required this.isBanned,
    required this.userPrivilegeLevel,
  });
  int id;
  String name;
  String email;
  String password;
  String phoneNumber;
  DateTime created;
  bool isConfirmed;
  bool isBanned;
  UserPrivilegeLevel userPrivilegeLevel;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"],
      password: json["password"],
      phoneNumber: json["phoneNumber"],
      email: json["email"],
      created: json["created"],
      isConfirmed: json["isConfirmed"],
      isBanned: json["isBanned"],
      userPrivilegeLevel:
          UserPrivilegeLevel.values.elementAt(json["userPrivilegeLevel"]));

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
}
