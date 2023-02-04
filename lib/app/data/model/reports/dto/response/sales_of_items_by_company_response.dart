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
    this.companyCode,
    this.companyName,
    this.totalSales,
  });

  int ?gallaryId;
  String? gallaryName;
  int ?companyCode;
  String? companyName;
  double ?totalSales;


  static List<SalesOfItemsByCompanyResponse> fromList(List<dynamic> json) => List.from(json.map((e) => SalesOfItemsByCompanyResponse.fromJson(e)));

  factory SalesOfItemsByCompanyResponse.fromJson(Map<String, dynamic> json) => SalesOfItemsByCompanyResponse(
    gallaryId: json["gallaryId"] == null ? null : json["gallaryId"],
    gallaryName: json["gallaryName"] == null ? null : json["gallaryName"],
    companyCode: json["companyCode"] == null ? null : json["companyCode"],
    companyName: json["companyName"] == null ? null : json["companyName"],
    totalSales: json["totalSales"] == null ? null : json["totalSales"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "gallaryId": gallaryId == null ? null : gallaryId,
    "gallaryName": gallaryName == null ? null : gallaryName,
    "companyCode": companyCode == null ? null : companyCode,
    "companyName": companyName == null ? null : companyName,
    "totalSales": totalSales == null ? null : totalSales,
  };
}
