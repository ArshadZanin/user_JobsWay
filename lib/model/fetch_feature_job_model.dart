import 'dart:convert';

FeatureJobFetch featureJobFetchFromJson(String str) => FeatureJobFetch.fromJson(json.decode(str));

String featureJobFetchToJson(FeatureJobFetch data) => json.encode(data.toJson());

class FeatureJobFetch {
  FeatureJobFetch({
    this.jobList,
  });

  List<JobList>? jobList;

  factory FeatureJobFetch.fromJson(Map<String, dynamic> json) => FeatureJobFetch(
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
    this.qualification,
    this.education,
    this.jobLocation,
    this.skills,
    this.language,
    this.companyId,
    this.hrId,
    this.payPlan,
    this.status,
  });

  String? id;
  String? jobTitle;
  String? jobCategory;
  String? minExp;
  String? maxExp;
  String? timeSchedule;
  List<String>? qualification;
  String? education;
  String? jobLocation;
  List<String>? skills;
  List<String>? language;
  String? companyId;
  String? hrId;
  String? payPlan;
  bool? status;

  factory JobList.fromJson(Map<String, dynamic> json) => JobList(
    id: json["_id"],
    jobTitle: json["jobTitle"],
    jobCategory: json["jobCategory"],
    minExp: json["minExp"],
    maxExp: json["maxExp"],
    timeSchedule: json["timeSchedule"],
    qualification: List<String>.from(json["qualification"].map((x) => x)),
    education: json["education"],
    jobLocation: json["jobLocation"],
    skills: List<String>.from(json["skills"].map((x) => x)),
    language: List<String>.from(json["language"].map((x) => x)),
    companyId: json["companyId"],
    hrId: json["hrId"],
    payPlan: json["payPlan"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "jobTitle": jobTitle,
    "jobCategory": jobCategory,
    "minExp": minExp,
    "maxExp": maxExp,
    "timeSchedule": timeSchedule,
    "qualification": List<dynamic>.from(qualification!.map((x) => x)),
    "education": education,
    "jobLocation": jobLocation,
    "skills": List<dynamic>.from(skills!.map((x) => x)),
    "language": List<dynamic>.from(language!.map((x) => x)),
    "companyId": companyId,
    "hrId": hrId,
    "payPlan": payPlan,
    "status": status,
  };
}
