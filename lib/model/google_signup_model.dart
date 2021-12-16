import 'dart:convert';

GoogleUser googleUserFromJson(String str) => GoogleUser.fromJson(json.decode(str));

String googleUserToJson(GoogleUser data) => json.encode(data.toJson());

class GoogleUser {
  GoogleUser({
    this.user,
    this.token,
  });

  User? user;
  String? token;

  factory GoogleUser.fromJson(Map<String, dynamic> json) => GoogleUser(
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user!.toJson(),
    "token": token,
  };
}

class User {
  User({
    this.id,
    this.email,
    this.password,
    this.name,
    this.ban,
  });

  String? id;
  String? email;
  String? password;
  String? name;
  bool? ban;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    email: json["email"],
    password: json["password"],
    name: json["name"],
    ban: json["ban"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "password": password,
    "name": name,
    "ban": ban,
  };
}
