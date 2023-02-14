// To parse this JSON data, do
//
//     final appResponse = appResponseFromJson(jsonString);

import 'dart:convert';

class AppResponse {
  AppResponse({
    this.id,
    this.dueDate,
    this.dueTime,

  });

  int? id;
  DateTime? dueDate;
  DateTime? dueTime;


  static List<AppResponse> fromList(dynamic json) => List.from(json.map((e)=> AppResponse.fromJson(e)));


  factory AppResponse.fromRawJson(String str) => AppResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AppResponse.fromJson(Map<String, dynamic> json) => AppResponse(
    id: json["id"],
    dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
    dueTime: json["dueTime"] == null ? null : DateTime.parse(json["dueTime"]),


  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dueDate" : dueDate != null ? dueDate!.toIso8601String() : null ,
    "dueTime" : dueTime != null ? dueTime!.toIso8601String() : null ,


  };
}
