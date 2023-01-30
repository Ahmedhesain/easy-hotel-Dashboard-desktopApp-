// To parse this JSON data, do
//
//     final appResponse = appResponseFromJson(jsonString);

import 'dart:convert';

class AppResponse {
  AppResponse({
    this.id,
    this.comingDate,

  });

  int? id;
  DateTime? comingDate;


  static List<AppResponse> fromList(dynamic json) => List.from(json.map((e)=> AppResponse.fromJson(e)));


  factory AppResponse.fromRawJson(String str) => AppResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AppResponse.fromJson(Map<String, dynamic> json) => AppResponse(
    id: json["id"],
    comingDate: json["comingDate"] == null ? null : DateTime.parse(json["comingDate"]),


  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comingDate" : comingDate != null ? comingDate!.toIso8601String() : null ,


  };
}
