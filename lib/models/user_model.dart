// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? role;
  String? picture;
  bool? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? token;

  User({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.role,
    this.picture,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    role: json["role"],
    picture: json["picture"],
    isVerified: json["isVerified"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "role": role,
    "picture": picture,
    "isVerified": isVerified,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "token": token,
  };
}
