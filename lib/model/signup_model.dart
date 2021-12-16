import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.status,
    required this.userDetails,
  });

  String status;
  UserDetails userDetails;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    userDetails: UserDetails.fromJson(json["userDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "userDetails": userDetails.toJson(),
  };
}

class UserDetails {
  UserDetails({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.phone,
    required this.email,
  });

  String firstName;
  String lastName;
  String password;
  String phone;
  String email;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    firstName: json["firstName"],
    lastName: json["lastName"],
    password: json["password"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "password": password,
    "phone": phone,
    "email": email,
  };
}
