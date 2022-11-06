// To parse this JSON data, do
//
//     final salesOfItemsByCompanyResponse = salesOfItemsByCompanyResponseFromJson(jsonString);

import 'dart:convert';

SalesOfItemsByCompanyResponse salesOfItemsByCompanyResponseFromJson(String str) => SalesOfItemsByCompanyResponse.fromJson(json.decode(str));

String salesOfItemsByCompanyResponseToJson(SalesOfItemsByCompanyResponse data) => json.encode(data.toJson());

class SalesOfItemsByCompanyResponse {
  SalesOfItemsByCompanyResponse({
    this.gallaryId,
    this.gallaryName,
    this.totalSales,
  });

  int ?gallaryId;
  String? gallaryName;
  double ?totalSales;


  static List<SalesOfItemsByCompanyResponse> fromList(List<dynamic> json) => List.from(json.map((e) => SalesOfItemsByCompanyResponse.fromJson(e)));

  factory SalesOfItemsByCompanyResponse.fromJson(Map<String, dynamic> json) => SalesOfItemsByCompanyResponse(
    gallaryId: json["gallaryId"] == null ? null : json["gallaryId"],
    gallaryName: json["gallaryName"] == null ? null : json["gallaryName"],
    totalSales: json["totalSales"] == null ? null : json["totalSales"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "gallaryId": gallaryId == null ? null : gallaryId,
    "gallaryName": gallaryName == null ? null : gallaryName,
    "totalSales": totalSales == null ? null : totalSales,
  };
}
