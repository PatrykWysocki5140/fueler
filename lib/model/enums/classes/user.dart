import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    required this.avatar,
    //required this.token,
    required this.firstname,
    required this.id,
    required this.lastname,
  });

  late final int id;

  @JsonKey(name: "first_name")
  final String firstname;

  @JsonKey(name: "last_name")
  final String lastname;

  final String avatar;
  //String token;
  //@JsonKey(nullable: true)

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return "$firstname $lastname".toString();
  }
}
