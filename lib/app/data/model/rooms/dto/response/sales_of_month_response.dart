// To parse this JSON data, do
//
//     final salesOfMonthResponse = salesOfMonthResponseFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

SalesOfMonthResponse salesOfMonthResponseFromJson(String str) => SalesOfMonthResponse.fromJson(json.decode(str));

String salesOfMonthResponseToJson(SalesOfMonthResponse data) => json.encode(data.toJson());

class SalesOfMonthResponse {
  SalesOfMonthResponse({
    this.valueFirstMonth,
    this.valueLastMonth,
  });

  double? valueFirstMonth;
  double? valueLastMonth;
  RxDouble ?all=0.0.obs;

  factory SalesOfMonthResponse.fromJson( dynamic json) => SalesOfMonthResponse(
    valueFirstMonth: json["valueFirstMonth"].toDouble(),
    valueLastMonth: json["valueLastMonth"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "valueFirstMonth": valueFirstMonth,
    "valueLastMonth": valueLastMonth,
  };
}
