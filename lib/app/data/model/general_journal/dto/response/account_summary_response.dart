// To parse this JSON data, do
//
//     final accountSummaryResponse = accountSummaryResponseFromJson(jsonString);

import 'dart:convert';

class AccountSummaryResponse {
  AccountSummaryResponse({
    // this.balance,
    this.costCenterId,
    this.creditAmount,
    this.date,
    this.discribtion,
    this.generalDecument,
    this.generalJournalId,
    this.generalStatement,
    this.glAccountName,
    this.glaccountId,
    this.glbranchId,
    this.debitAmount,
    this.serial,
    this.symbolId,
    this.symbolName,
  });

  num balance = 0;

  num get sub =>  (debitAmount??0) - (creditAmount??0);

  final int? costCenterId;
  final num? creditAmount;
  final num? debitAmount;
  final DateTime? date;
  final String? discribtion;
  final num? generalDecument;
  final int? generalJournalId;
  final String? generalStatement;
  final String? glAccountName;
  final int? glaccountId;
  final int? glbranchId;
  final String? serial;
  final int? symbolId;
  final String? symbolName;

  static List<AccountSummaryResponse> fromList(List<dynamic> json) => List<AccountSummaryResponse>.from(json.map((e) => AccountSummaryResponse.fromJson(e)));

  factory AccountSummaryResponse.fromJson(Map<String, dynamic> json) => AccountSummaryResponse(
    // balance: json["balance"],
    costCenterId: json["costCenterId"],
    creditAmount: json["creditAmount"],
    date: DateTime.parse(json["date"]),
    discribtion: json["discribtion"],
    generalDecument: json["generalDecument"],
    debitAmount: json["debitAmount"],
    generalJournalId: json["generalJournalId"],
    generalStatement: json["generalStatement"],
    glAccountName: json["glAccountName"],
    glaccountId: json["glaccountId"],
    glbranchId: json["glbranchId"],
    serial: json["serial"],
    symbolId: json["symbolId"],
    symbolName: json["symbolName"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "costCenterId": costCenterId,
    "creditAmount": creditAmount,
    "date": date?.toIso8601String(),
    "discribtion": discribtion,
    "debitAmount": debitAmount,
    "generalDecument": generalDecument,
    "generalJournalId": generalJournalId,
    "generalStatement": generalStatement,
    "glAccountName": glAccountName,
    "glaccountId": glaccountId,
    "glbranchId": glbranchId,
    "serial": serial,
    "symbolId": symbolId,
    "symbolName": symbolName,
  };
}
