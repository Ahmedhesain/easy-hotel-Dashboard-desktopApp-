// To parse this JSON data, do
//
//     final mostBuingClientsResponse = mostBuingClientsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

class MostBuingClientsResponse {
  MostBuingClientsResponse({
    this.id,
    this.name,
    this.numbers,
  });

  int? id;
  String? name;
  int? numbers;
  RxInt added=0.obs;
  static List<MostBuingClientsResponse> fromList(dynamic json) => List.from(json.map((e)=> MostBuingClientsResponse.fromJson(e)));

  factory MostBuingClientsResponse.fromRawJson(String str) => MostBuingClientsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MostBuingClientsResponse.fromJson(Map<String, dynamic> json) => MostBuingClientsResponse(
    id: json["id"],
    name: json["name"],
    numbers: json["numbers"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "numbers": numbers,
  };
}
