// To parse this JSON data, do
//
//     final groupValueForDayAndMonthResponse = groupValueForDayAndMonthResponseFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

class GroupValueForDayAndMonthResponse {
  GroupValueForDayAndMonthResponse({
    this.id,
    this.name,
    this.countOrderDay,
    this.valueOrderDay,
    this.countOrderMonth,
    this.valueOrderMonth,


  });

  int? id;
  String? name;
  int? countOrderDay;
  double? valueOrderDay;
  int? countOrderMonth;
  double? valueOrderMonth;
  RxDouble valueOrderMonthAdded=0.0.obs;
  RxInt added=0.obs;

  static List<GroupValueForDayAndMonthResponse> fromList(dynamic json) => List.from(json.map((e)=> GroupValueForDayAndMonthResponse.fromJson(e)));


  factory GroupValueForDayAndMonthResponse.fromRawJson(String str) => GroupValueForDayAndMonthResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GroupValueForDayAndMonthResponse.fromJson(Map<String, dynamic> json) => GroupValueForDayAndMonthResponse(
    id: json["id"],
    name: json["name"],
    countOrderDay: json["countOrderDay"],
    // valueOrderDay: json["valueOrderDay"].toDouble(),
    countOrderMonth: json["countOrderMonth"],
    // valueOrderMonth: json["valueOrderMonth"].toDouble(),
      valueOrderMonth: json["valueOrderMonth"] == null ? null : json["valueOrderMonth"].toDouble(),
      valueOrderDay: json["valueOrderDay"] == null ? null : json["valueOrderDay"].toDouble()
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "countOrderDay": countOrderDay,
    "valueOrderDay": valueOrderDay,
    "countOrderMonth": countOrderMonth,
    "valueOrderMonth": valueOrderMonth,
  };
}
