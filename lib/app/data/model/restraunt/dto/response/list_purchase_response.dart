// To parse this JSON data, do
//
//     final listPurchaseResponse = listPurchaseResponseFromJson(jsonString);

import 'dart:convert';

class ListPurchaseResponse {
  ListPurchaseResponse({
    this.totalOrders,
    this.lateOrders,
  });

  int? totalOrders;
  int? lateOrders;

  factory ListPurchaseResponse.fromRawJson(String str) => ListPurchaseResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListPurchaseResponse.fromJson( dynamic json) => ListPurchaseResponse(
    totalOrders: json["totalOrders"],
    lateOrders: json["lateOrders"],
  );

  Map<String, dynamic> toJson() => {
    "totalOrders": totalOrders,
    "lateOrders": lateOrders,
  };
}
