// To parse this JSON data, do
//
//     final findCustomerBalanceResponse = findCustomerBalanceResponseFromJson(jsonString);

import 'dart:convert';

FindCustomersBalanceResponse findCustomerBalanceResponseFromJson(String str) => FindCustomersBalanceResponse.fromJson(json.decode(str));

String findCustomerBalanceResponseToJson(FindCustomersBalanceResponse data) => json.encode(data.toJson());

class FindCustomersBalanceResponse {
  FindCustomersBalanceResponse({
    this.balance,
    this.clientCode,
    this.clientName,
    this.creditor,
    this.debit,
    this.openningBalance,
    this.organizationsiteId,
  });

  double? balance;
  String ?clientCode;
  String ?clientName;
  int ?creditor;
  double? debit;
  num ?openningBalance;
  num ?organizationsiteId;
  static List<FindCustomersBalanceResponse> fromList(List<dynamic> json) => List.from(json.map((e) => FindCustomersBalanceResponse.fromJson(e)));

  factory FindCustomersBalanceResponse.fromJson(Map<String, dynamic> json) => FindCustomersBalanceResponse(
    balance: json["balance"] == null ? null : json["balance"].toDouble(),
    clientCode: json["clientCode"] == null ? null : json["clientCode"],
    clientName: json["clientName"] == null ? null : json["clientName"],
    creditor: json["creditor"] == null ? null : json["creditor"],
    debit: json["debit"] == null ? null : json["debit"].toDouble(),
    openningBalance: json["openningBalance"] == null ? null : json["openningBalance"],
    organizationsiteId: json["organizationsiteId"] == null ? null : json["organizationsiteId"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance == null ? null : balance,
    "clientCode": clientCode == null ? null : clientCode,
    "clientName": clientName == null ? null : clientName,
    "creditor": creditor == null ? null : creditor,
    "debit": debit == null ? null : debit,
    "openningBalance": openningBalance == null ? null : openningBalance,
    "organizationsiteId": organizationsiteId == null ? null : organizationsiteId,
  };
}
