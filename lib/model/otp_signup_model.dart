import 'dart:convert';

UserModelOtp userModelOtpFromJson(String str) => UserModelOtp.fromJson(json.decode(str));

String userModelOtpToJson(UserModelOtp data) => json.encode(data.toJson());

class UserModelOtp {
  UserModelOtp({
    required this.user,
    required this.token,
  });

  User user;
  String token;

  factory UserModelOtp.fromJson(Map<String, dynamic> json) => UserModelOtp(
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
  };
}

class User {
  User({
    required this.id,
    required this.phone,
    required this.password,
    required this.name,
    required this.ban,
    required this.email,
  });

  String id;
  String phone;
  String password;
  String name;
  bool ban;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    phone: json["phone"],
    password: json["password"],
    name: json["name"],
    ban: json["ban"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "phone": phone,
    "password": password,
    "name": name,
    "ban": ban,
    "email": email,
  };
}
