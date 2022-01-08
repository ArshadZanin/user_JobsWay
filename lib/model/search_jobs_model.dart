// import 'dart:convert';
//
// SearchJobFetch searchJobFetchFromJson(String str) => SearchJobFetch.fromJson(json.decode(str));
//
// String searchJobFetchToJson(SearchJobFetch data) => json.encode(data.toJson());
//
// class SearchJobFetch {
//   SearchJobFetch({
//     this.jobList,
//   });
//
//   List<JobList>? jobList;
//
//   factory SearchJobFetch.fromJson(Map<String, dynamic> json) => SearchJobFetch(
//     jobList: List<JobList>.from(json["jobList"].map((x) => JobList.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "jobList": List<dynamic>.from(jobList!.map((x) => x.toJson())),
//   };
// }
//
// class JobList {
//   JobList({
//     this.id,
//     this.jobTitle,
//     this.jobCategory,
//     this.minExp,
//     this.maxExp,
//     this.timeSchedule,
//     this.minSalary,
//     this.maxSalary,
//     this.qualification,
//     this.education,
//     this.jobLocation,
//     this.skills,
//     this.language,
//     this.companyId,
//     this.hrId,
//     this.status,
//     this.payPlan,
//     this.applications,
//   });
//
//   String? id;
//   String? jobTitle;
//   String? jobCategory;
//   String? minExp;
//   String? maxExp;
//   String? timeSchedule;
//   String? minSalary;
//   String? maxSalary;
//   List<String>? qualification;
//   String? education;
//   String? jobLocation;
//   List<String>? skills;
//   List<String>? language;
//   String? companyId;
//   String? hrId;
//   bool? status;
//   String? payPlan;
//   List<Application>? applications;
//
//   factory JobList.fromJson(Map<String, dynamic> json) => JobList(
//     id: json["_id"],
//     jobTitle: json["jobTitle"],
//     jobCategory: json["jobCategory"],
//     minExp: json["minExp"],
//     maxExp: json["maxExp"],
//     timeSchedule: json["timeSchedule"],
//     minSalary: json["minSalary"],
//     maxSalary: json["maxSalary"],
//     qualification: List<String>.from(json["qualification"].map((x) => x)),
//     education: json["education"],
//     jobLocation: json["jobLocation"],
//     skills: List<String>.from(json["skills"].map((x) => x)),
//     language: List<String>.from(json["language"].map((x) => x)),
//     companyId: json["companyId"],
//     hrId: json["hrId"],
//     status: json["status"],
//     payPlan: json["payPlan"],
//     applications: json["applications"] == null ? null : List<Application>.from(json["applications"].map((x) => Application.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "jobTitle": jobTitle,
//     "jobCategory": jobCategory,
//     "minExp": minExp,
//     "maxExp": maxExp,
//     "timeSchedule": timeSchedule,
//     "minSalary": minSalary,
//     "maxSalary": maxSalary,
//     "qualification": List<dynamic>.from(qualification!.map((x) => x)),
//     "education": education,
//     "jobLocation": jobLocation,
//     "skills": List<dynamic>.from(skills!.map((x) => x)),
//     "language": List<dynamic>.from(language!.map((x) => x)),
//     "companyId": companyId,
//     "hrId": hrId,
//     "status": status,
//     "payPlan": payPlan,
//     "applications": applications == null ? null : List<dynamic>.from(applications!.map((x) => x.toJson())),
//   };
// }
//
// class Application {
//   Application({
//     this.userId,
//     this.firstName,
//     this.secondName,
//     this.email,
//     this.phone,
//     this.location,
//     this.experience,
//     this.portfolio,
//     this.imgUrl,
//     this.resumeUrl,
//     this.status,
//     this.lastName,
//   });
//
//   String? userId;
//   String? firstName;
//   String? secondName;
//   String? email;
//   String? phone;
//   String? location;
//   String? experience;
//   String? portfolio;
//   String? imgUrl;
//   String? resumeUrl;
//   String? status;
//   String? lastName;
//
//   factory Application.fromJson(Map<String, dynamic> json) => Application(
//     userId: json["userId"],
//     firstName: json["firstName"],
//     secondName: json["secondName"],
//     email: json["email"],
//     phone: json["phone"],
//     location: json["location"],
//     experience: json["experience"],
//     portfolio: json["portfolio"],
//     imgUrl: json["imgUrl"],
//     resumeUrl: json["resumeUrl"],
//     status: json["status"],
//     lastName: json["lastName"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "userId": userId,
//     "firstName": firstName,
//     "secondName": secondName,
//     "email": email,
//     "phone": phone,
//     "location": location,
//     "experience": experience,
//     "portfolio": portfolio,
//     "imgUrl": imgUrl,
//     "resumeUrl": resumeUrl,
//     "status": status,
//     "lastName": lastName,
//   };
// }
