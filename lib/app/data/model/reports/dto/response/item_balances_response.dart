// To parse this JSON data, do
//
//     final itemsBalanceResponse = itemsBalanceResponseFromJson(jsonString);

import 'dart:convert';

ItemsBalanceResponse itemsBalanceResponseFromJson(String str) => ItemsBalanceResponse.fromJson(json.decode(str));

String itemsBalanceResponseToJson(ItemsBalanceResponse data) => json.encode(data.toJson());

class ItemsBalanceResponse {
  ItemsBalanceResponse({
    this.code,
    this.costAverage,
    this.name,
    this.sallary,
  });

  String ?code;
  num ?costAverage;
  String? name;
  num ?sallary;
  static List<ItemsBalanceResponse> fromList(List<dynamic> json) => List.from(json.map((e) => ItemsBalanceResponse.fromJson(e)));

  factory ItemsBalanceResponse.fromJson(Map<String, dynamic> json) => ItemsBalanceResponse(
    code: json["code"] == null ? null : json["code"],
    costAverage: json["costAverage"] == null ? null : json["costAverage"],
    name: json["name"] == null ? null : json["name"],
    sallary: json["sallary"] == null ? null : json["sallary"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "costAverage": costAverage == null ? null : costAverage,
    "name": name == null ? null : name,
    "sallary": sallary == null ? null : sallary,
  };
}
