// To parse this JSON data, do
//
//     final findStatementOfBondsByBranchReportResponse = findStatementOfBondsByBranchReportResponseFromJson(jsonString);

import 'dart:convert';

FindStatementOfBondsByBranchReportResponse findStatementOfBondsByBranchReportResponseFromJson(String str) => FindStatementOfBondsByBranchReportResponse.fromJson(json.decode(str));

String findStatementOfBondsByBranchReportResponseToJson(FindStatementOfBondsByBranchReportResponse data) => json.encode(data.toJson());

class FindStatementOfBondsByBranchReportResponse {
  FindStatementOfBondsByBranchReportResponse({
    this.galleryCode,
    this.galleryName,
    this.paymentType,
    this.totalAmount,
    this.type,
  });

  String ?galleryCode;
  String ?galleryName;
  String ?paymentType;
  num ?totalAmount;
  String? type;

  static List<FindStatementOfBondsByBranchReportResponse> fromList(List<dynamic> json) => List.from(json.map((e) => FindStatementOfBondsByBranchReportResponse.fromJson(e)));


  factory FindStatementOfBondsByBranchReportResponse.fromJson(Map<String, dynamic> json) => FindStatementOfBondsByBranchReportResponse(
    galleryCode: json["galleryCode"] == null ? null : json["galleryCode"],
    galleryName: json["galleryName"] == null ? null : json["galleryName"],
    paymentType: json["paymentType"] == null ? null : json["paymentType"],
    totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "galleryCode": galleryCode == null ? null : galleryCode,
    "galleryName": galleryName == null ? null : galleryName,
    "paymentType": paymentType == null ? null : paymentType,
    "totalAmount": totalAmount == null ? null : totalAmount,
    "type": type == null ? null : type,
  };
}
