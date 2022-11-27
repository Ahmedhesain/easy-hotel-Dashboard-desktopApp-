// To parse this JSON data, do
//
//     final balanceGalaryResponse = balanceGalaryResponseFromJson(jsonString);

import 'dart:convert';

BalanceGalaryResponse balanceGalaryResponseFromJson(String str) => BalanceGalaryResponse.fromJson(json.decode(str));

String balanceGalaryResponseToJson(BalanceGalaryResponse data) => json.encode(data.toJson());

class BalanceGalaryResponse {
  BalanceGalaryResponse({
    this.gallaryName,
    this.bankName,
    this.transactionType,
    this.value,
  });
  String ?gallaryName;
  String ?bankName;
  String ?transactionType;
  num ?value;

  static List<BalanceGalaryResponse> fromList(List<dynamic> json) => List.from(json.map((e) => BalanceGalaryResponse.fromJson(e)));


  factory BalanceGalaryResponse.fromJson(Map<String, dynamic> json) => BalanceGalaryResponse(
    gallaryName: json["gallaryName"] == null ? null : json["gallaryName"],
    bankName: json["bankName"] == null ? null : json["bankName"],
    transactionType: json["transactionType"] == null ? null : json["transactionType"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "gallaryName": gallaryName == null ? null : gallaryName,
    "bankName": bankName == null ? null : bankName,
    "transactionType": transactionType == null ? null : transactionType,
    "value": value == null ? null : value,
  };
}
