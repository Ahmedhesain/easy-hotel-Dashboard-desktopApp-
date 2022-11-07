// To parse this JSON data, do
//
//     final findSalesValueAddedResponse = findSalesValueAddedResponseFromJson(jsonString);

import 'dart:convert';

FindSalesValueAddedResponse findSalesValueAddedResponseFromJson(String str) => FindSalesValueAddedResponse.fromJson(json.decode(str));

String findSalesValueAddedResponseToJson(FindSalesValueAddedResponse data) => json.encode(data.toJson());

class FindSalesValueAddedResponse {
  FindSalesValueAddedResponse({
    this.galleryName,
    this.tax,
    this.totalAfterTax,
    this.totalBeforeTax,
  });

  String ?galleryName;
  double ?tax;
  double ?totalAfterTax;
  double ?totalBeforeTax;
  static List<FindSalesValueAddedResponse> fromList(List<dynamic> json) => List.from(json.map((e) => FindSalesValueAddedResponse.fromJson(e)));


  factory FindSalesValueAddedResponse.fromJson(Map<String, dynamic> json) => FindSalesValueAddedResponse(
    galleryName: json["galleryName"] == null ? null : json["galleryName"],
    tax: json["tax"] == null ? null : json["tax"].toDouble(),
    totalAfterTax: json["totalAfterTax"] == null ? null : json["totalAfterTax"].toDouble(),
    totalBeforeTax: json["totalBeforeTax"] == null ? null : json["totalBeforeTax"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "galleryName": galleryName == null ? null : galleryName,
    "tax": tax == null ? null : tax,
    "totalAfterTax": totalAfterTax == null ? null : totalAfterTax,
    "totalBeforeTax": totalBeforeTax == null ? null : totalBeforeTax,
  };
}
