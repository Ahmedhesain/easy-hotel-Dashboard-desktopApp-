// To parse this JSON data, do
//
//     final findSalesValueAddedDetailsResponse = findSalesValueAddedDetailsResponseFromJson(jsonString);

import 'dart:convert';

FindSalesValueAddedDetailsResponse findSalesValueAddedDetailsResponseFromJson(String str) => FindSalesValueAddedDetailsResponse.fromJson(json.decode(str));

String findSalesValueAddedDetailsResponseToJson(FindSalesValueAddedDetailsResponse data) => json.encode(data.toJson());

class FindSalesValueAddedDetailsResponse {
  FindSalesValueAddedDetailsResponse({
    this.discount,
    this.employeeName,
    this.galleryName,
    this.invoiceDate,
    this.invoiceNumber,
    this.invoiceType,
    this.tax,
    this.totalAfterTax,
    this.totalBeforeTax,
  });

  double ?discount;
  String ?employeeName;
  String ?galleryName;
  DateTime? invoiceDate;
  int ?invoiceNumber;
  int ?invoiceType;
  double? tax;
  double ?totalAfterTax;
  double ?totalBeforeTax;

  static List<FindSalesValueAddedDetailsResponse> fromList(List<dynamic> json) => List.from(json.map((e) => FindSalesValueAddedDetailsResponse.fromJson(e)));


  factory FindSalesValueAddedDetailsResponse.fromJson(Map<String, dynamic> json) => FindSalesValueAddedDetailsResponse(
    discount: json["discount"] == null ? null : json["discount"].toDouble(),
    employeeName: json["employeeName"] == null ? null : json["employeeName"],
    galleryName: json["galleryName"] == null ? null : json["galleryName"],
    invoiceDate: json["invoiceDate"] == null ? null : DateTime.parse(json["invoiceDate"]),
    invoiceNumber: json["invoiceNumber"] == null ? null : json["invoiceNumber"],
    invoiceType: json["invoiceType"] == null ? null : json["invoiceType"],
    tax: json["tax"] == null ? null : json["tax"].toDouble(),
    totalAfterTax: json["totalAfterTax"] == null ? null : json["totalAfterTax"].toDouble(),
    totalBeforeTax: json["totalBeforeTax"] == null ? null : json["totalBeforeTax"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "discount": discount == null ? null : discount,
    "employeeName": employeeName == null ? null : employeeName,
    "galleryName": galleryName == null ? null : galleryName,
    "invoiceDate": invoiceDate == null ? null : invoiceDate?.toIso8601String(),
    "invoiceNumber": invoiceNumber == null ? null : invoiceNumber,
    "invoiceType": invoiceType == null ? null : invoiceType,
    "tax": tax == null ? null : tax,
    "totalAfterTax": totalAfterTax == null ? null : totalAfterTax,
    "totalBeforeTax": totalBeforeTax == null ? null : totalBeforeTax,
  };
}
