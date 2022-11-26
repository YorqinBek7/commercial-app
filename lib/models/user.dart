import 'package:commercial_app/models/addres.dart';
import 'package:commercial_app/models/name.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "address")
  Address address;

  @JsonKey(defaultValue: 0, name: "id")
  int id;
  @JsonKey(defaultValue: "", name: "email")
  String email;
  @JsonKey(defaultValue: "", name: "username")
  String username;
  @JsonKey(defaultValue: "", name: "password")
  String password;
  @JsonKey(name: "name")
  Name name;
  @JsonKey(defaultValue: "", name: "phone")
  String phone;
  @JsonKey(defaultValue: 0, name: "__v")
  int v;

  User({
    required this.v,
    required this.address,
    required this.email,
    required this.id,
    required this.name,
    required this.password,
    required this.phone,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
