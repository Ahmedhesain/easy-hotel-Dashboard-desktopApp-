// To parse this JSON data, do
//
//     final balanceGalaryUnpaidResponse = balanceGalaryUnpaidResponseFromJson(jsonString);

import 'dart:convert';

BalanceGalaryUnpaidResponse balanceGalaryUnpaidResponseFromJson(String str) => BalanceGalaryUnpaidResponse.fromJson(json.decode(str));

String balanceGalaryUnpaidResponseToJson(BalanceGalaryUnpaidResponse data) => json.encode(data.toJson());

class BalanceGalaryUnpaidResponse {
  BalanceGalaryUnpaidResponse({
    this.type,
    this.markEdit,
    this.gallaryName,
    this.value,
  });

  String? type;
  bool? markEdit;
  String? gallaryName;
  double? value;

  static List<BalanceGalaryUnpaidResponse> fromList(List<dynamic> json) => List.from(json.map((e) => BalanceGalaryUnpaidResponse.fromJson(e)));


  factory BalanceGalaryUnpaidResponse.fromJson(Map<String, dynamic> json) => BalanceGalaryUnpaidResponse(
    type: json["type"] == null ? null : json["type"],
    markEdit: json["markEdit"] == null ? null : json["markEdit"],
    gallaryName: json["gallaryName"] == null ? null : json["gallaryName"],
    value: json["value"] == null ? null : json["value"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "markEdit": markEdit == null ? null : markEdit,
    "gallaryName": gallaryName == null ? null : gallaryName,
    "value": value == null ? null : value,
  };
}
