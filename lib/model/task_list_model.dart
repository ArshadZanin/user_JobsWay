import 'dart:convert';

TaskList taskListFromJson(String str) => TaskList.fromJson(json.decode(str));

String taskListToJson(TaskList data) => json.encode(data.toJson());

class TaskList {
  TaskList({
    this.taskList,
  });

  List<TaskListElement>? taskList;

  factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
    taskList: List<TaskListElement>.from(json["taskList"].map((x) => TaskListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "taskList": List<dynamic>.from(taskList!.map((x) => x.toJson())),
  };
}

class TaskListElement {
  TaskListElement({
    this.id,
    this.userId,
    this.jobId,
    this.status,
    this.companyId,
    this.taskQuestions,
    this.time,
    this.submitType,
    this.companyDetails,
  });

  String? id;
  String? userId;
  String? jobId;
  String? status;
  String? companyId;
  TaskQuestions? taskQuestions;
  String? time;
  String? submitType;
  List<CompanyDetail>? companyDetails;

  factory TaskListElement.fromJson(Map<String, dynamic> json) => TaskListElement(
    id: json["_id"],
    userId: json["userId"],
    jobId: json["jobId"],
    status: json["status"],
    companyId: json["companyId"],
    taskQuestions: TaskQuestions.fromJson(json["taskQuestions"]),
    time: json["time"],
    submitType: json["submitType"],
    companyDetails: List<CompanyDetail>.from(json["companyDetails"].map((x) => CompanyDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "jobId": jobId,
    "status": status,
    "companyId": companyId,
    "taskQuestions": taskQuestions!.toJson(),
    "time": time,
    "submitType": submitType,
    "companyDetails": List<dynamic>.from(companyDetails!.map((x) => x.toJson())),
  };
}

class CompanyDetail {
  CompanyDetail({
    this.id,
    this.companyName,
    this.location,
    this.logoUrl,
    this.status,
    this.ban,
  });

  String? id;
  String? companyName;
  String? location;
  String? logoUrl;
  bool? status;
  bool? ban;

  factory CompanyDetail.fromJson(Map<String, dynamic> json) => CompanyDetail(
    id: json["_id"],
    companyName: json["companyName"],
    location: json["location"],
    logoUrl: json["logoUrl"],
    status: json["status"],
    ban: json["ban"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "companyName": companyName,
    "location": location,
    "logoUrl": logoUrl,
    "status": status,
    "ban": ban,
  };
}

class TaskQuestions {
  TaskQuestions({
    this.q1,
    this.q2,
    this.q3,
    this.q4,
  });

  String? q1;
  String? q2;
  String? q3;
  String? q4;

  factory TaskQuestions.fromJson(Map<String, dynamic> json) => TaskQuestions(
    q1: json["q1"],
    q2: json["q2"],
    q3: json["q3"],
    q4: json["q4"],
  );

  Map<String, dynamic> toJson() => {
    "q1": q1,
    "q2": q2,
    "q3": q3,
    "q4": q4,
  };
}
