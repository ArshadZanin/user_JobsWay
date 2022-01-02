import 'dart:convert';

JobFetch jobFetchFromJson(String str) => JobFetch.fromJson(json.decode(str));

String jobFetchToJson(JobFetch data) => json.encode(data.toJson());

class JobFetch {
  JobFetch({
    this.jobList,
  });

  List<JobList>? jobList;

  factory JobFetch.fromJson(Map<String, dynamic> json) => JobFetch(
    jobList: List<JobList>.from(json["jobList"].map((x) => JobList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "jobList": List<dynamic>.from(jobList!.map((x) => x.toJson())),
  };
}

class JobList {
  JobList({
    this.id,
    this.jobTitle,
    this.jobCategory,
    this.minExp,
    this.maxExp,
    this.timeSchedule,
    this.minSalary,
    this.maxSalary,
    this.qualification,
    this.education,
    this.jobLocation,
    this.skills,
    this.language,
    this.companyId,
    this.hrId,
    this.status,
    this.payPlan,
    this.applications,
    this.companyDetails,
  });

  String? id;
  String? jobTitle;
  String? jobCategory;
  String? minExp;
  String? maxExp;
  String? timeSchedule;
  String? minSalary;
  String? maxSalary;
  List<String>? qualification;
  String? education;
  String? jobLocation;
  List<String>? skills;
  List<String>? language;
  String? companyId;
  String? hrId;
  bool? status;
  String? payPlan;
  Applications? applications;
  List<CompanyDetail>? companyDetails;

  factory JobList.fromJson(Map<String, dynamic> json) => JobList(
    id: json["_id"],
    jobTitle: json["jobTitle"],
    jobCategory: json["jobCategory"],
    minExp: json["minExp"],
    maxExp: json["maxExp"],
    timeSchedule: json["timeSchedule"],
    minSalary: json["minSalary"],
    maxSalary: json["maxSalary"],
    qualification: List<String>.from(json["qualification"].map((x) => x)),
    education: json["education"],
    jobLocation: json["jobLocation"],
    skills: List<String>.from(json["skills"].map((x) => x)),
    language: List<String>.from(json["language"].map((x) => x)),
    companyId: json["companyId"],
    hrId: json["hrId"],
    status: json["status"],
    payPlan: json["payPlan"],
    applications: Applications.fromJson(json["applications"]),
    companyDetails: List<CompanyDetail>.from(json["companyDetails"].map((x) => CompanyDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "jobTitle": jobTitle,
    "jobCategory": jobCategory,
    "minExp": minExp,
    "maxExp": maxExp,
    "timeSchedule": timeSchedule,
    "minSalary": minSalary,
    "maxSalary": maxSalary,
    "qualification": List<dynamic>.from(qualification!.map((x) => x)),
    "education": education,
    "jobLocation": jobLocation,
    "skills": List<dynamic>.from(skills!.map((x) => x)),
    "language": List<dynamic>.from(language!.map((x) => x)),
    "companyId": companyId,
    "hrId": hrId,
    "status": status,
    "payPlan": payPlan,
    "applications": applications!.toJson(),
    "companyDetails": List<dynamic>.from(companyDetails!.map((x) => x.toJson())),
  };
}

class Applications {
  Applications({
    this.userId,
    this.firstName,
    this.secondName,
    this.email,
    this.phone,
    this.location,
    this.experience,
    this.portfolio,
    this.imgUrl,
    this.resumeUrl,
    this.status,
  });

  String? userId;
  String? firstName;
  String? secondName;
  String? email;
  String? phone;
  String? location;
  String? experience;
  String? portfolio;
  String? imgUrl;
  String? resumeUrl;
  String? status;

  factory Applications.fromJson(Map<String, dynamic> json) => Applications(
    userId: json["userId"],
    firstName: json["firstName"],
    secondName: json["secondName"],
    email: json["email"],
    phone: json["phone"],
    location: json["location"],
    experience: json["experience"],
    portfolio: json["portfolio"],
    imgUrl: json["imgUrl"],
    resumeUrl: json["resumeUrl"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "firstName": firstName,
    "secondName": secondName,
    "email": email,
    "phone": phone,
    "location": location,
    "experience": experience,
    "portfolio": portfolio,
    "imgUrl": imgUrl,
    "resumeUrl": resumeUrl,
    "status": status,
  };
}

class CompanyDetail {
  CompanyDetail({
    this.id,
    this.companyName,
    this.industry,
    this.email,
    this.location,
    this.phone,
    this.bio,
    this.website,
    this.linkedIn,
    this.facebook,
    this.twitter,
    this.instagram,
    this.password,
    this.logoUrl,
    this.status,
    this.ban,
  });

  String? id;
  String? companyName;
  String? industry;
  String? email;
  String? location;
  String? phone;
  String? bio;
  String? website;
  String? linkedIn;
  String? facebook;
  String? twitter;
  String? instagram;
  String? password;
  String? logoUrl;
  bool? status;
  bool? ban;

  factory CompanyDetail.fromJson(Map<String, dynamic> json) => CompanyDetail(
    id: json["_id"],
    companyName: json["companyName"],
    industry: json["industry"],
    email: json["email"],
    location: json["location"],
    phone: json["phone"],
    bio: json["bio"],
    website: json["website"],
    linkedIn: json["linkedIn"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    instagram: json["instagram"],
    password: json["password"],
    logoUrl: json["logoUrl"],
    status: json["status"],
    ban: json["ban"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "companyName": companyName,
    "industry": industry,
    "email": email,
    "location": location,
    "phone": phone,
    "bio": bio,
    "website": website,
    "linkedIn": linkedIn,
    "facebook": facebook,
    "twitter": twitter,
    "instagram": instagram,
    "password": password,
    "logoUrl": logoUrl,
    "status": status,
    "ban": ban,
  };
}
