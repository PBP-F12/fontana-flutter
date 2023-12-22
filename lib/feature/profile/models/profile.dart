// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  String username;
  String fullName;
  String role;

  Profile({
    required this.username,
    required this.fullName,
    required this.role,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        username: json["username"],
        fullName: json["fullName"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "fullName": fullName,
        "role": role,
      };
}
