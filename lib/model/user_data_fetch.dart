// To parse this JSON data, do
//
//     final userDataFetch = userDataFetchFromJson(jsonString);

import 'dart:convert';

UserDataFetch userDataFetchFromJson(String str) => UserDataFetch.fromJson(json.decode(str));

String userDataFetchToJson(UserDataFetch data) => json.encode(data.toJson());

class UserDataFetch {
  UserDataFetch({
    this.id,
    this.email,
    this.password,
    this.name,
    this.ban,
    this.imgUrl,
    this.designation,
    this.experience,
    this.facebook,
    this.instagram,
    this.linkedIn,
    this.location,
    this.phone,
    this.portfolio,
    this.skills,
    this.twitter,
  });

  String? id;
  String? email;
  String? password;
  String? name;
  bool? ban;
  String? imgUrl;
  String? designation;
  List<Experience>? experience;
  String? facebook;
  String? instagram;
  String? linkedIn;
  String? location;
  String? phone;
  String? portfolio;
  List<String>? skills;
  String? twitter;

  factory UserDataFetch.fromJson(Map<String, dynamic> json) => UserDataFetch(
    id: json["_id"],
    email: json["email"],
    password: json["password"],
    name: json["name"],
    ban: json["ban"],
    imgUrl: json["imgUrl"],
    designation: json["designation"],
    experience: List<Experience>.from(json["experience"].map((x) => Experience.fromJson(x))),
    facebook: json["facebook"],
    instagram: json["instagram"],
    linkedIn: json["linkedIn"],
    location: json["location"],
    phone: json["phone"],
    portfolio: json["portfolio"],
    skills: List<String>.from(json["skills"].map((x) => x)),
    twitter: json["twitter"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "password": password,
    "name": name,
    "ban": ban,
    "imgUrl": imgUrl,
    "designation": designation,
    "experience": List<dynamic>.from(experience!.map((x) => x.toJson())),
    "facebook": facebook,
    "instagram": instagram,
    "linkedIn": linkedIn,
    "location": location,
    "phone": phone,
    "portfolio": portfolio,
    "skills": List<dynamic>.from(skills!.map((x) => x)),
    "twitter": twitter,
  };
}

class Experience {
  Experience({
    this.yearFrom,
    this.yearTo,
    this.positionTitle,
    this.desc,
  });

  String? yearFrom;
  String? yearTo;
  String? positionTitle;
  String? desc;

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    yearFrom: json["yearFrom"],
    yearTo: json["yearTo"],
    positionTitle: json["positionTitle"],
    desc: json["desc"],
  );

  Map<String, dynamic> toJson() => {
    "yearFrom": yearFrom,
    "yearTo": yearTo,
    "positionTitle": positionTitle,
    "desc": desc,
  };
}
