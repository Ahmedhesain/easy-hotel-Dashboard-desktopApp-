// To parse this JSON data, do
//
//     final profitOfItemsSoldRequest = profitOfItemsSoldRequestFromJson(jsonString);

import 'dart:convert';

import 'package:toby_bills/app/data/model/reports/dto/request/find_custome_balance_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';



class SalesForPeriodRequest {
  SalesForPeriodRequest({
    this.branchId,
    this.dateFrom,
    this.dateTo,
    this.notZeroValue,
    this.zeroValue,
    this.invInventoryDtoList,
  });

  int ?branchId;
  DateTime? dateFrom;
  DateTime ?dateTo;
  bool ?notZeroValue;
  bool ?zeroValue;

  List<DtoList>? invInventoryDtoList;

  factory SalesForPeriodRequest.fromJson(Map<String, dynamic> json) => SalesForPeriodRequest(
    branchId: json["branchId"] == null ? null : json["branchId"],
    dateFrom: json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
    dateTo: json["dateTo"] == null ? null : DateTime.parse(json["dateTo"]),
    notZeroValue: json["notZeroValue"] == null ? null : json["notZeroValue"],
    zeroValue: json["zeroValue"] == null ? null : json["zeroValue"],

    invInventoryDtoList: json["invInventoryDTOList"] == null ? null : List<DtoList>.from(json["invInventoryDTOList"].map((x) => DtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "branchId": branchId == null ? null : branchId,
    "dateFrom": dateFrom == null ? null : dateFrom?.toIso8601String(),
    "dateTo": dateTo == null ? null : dateTo?.toIso8601String(),
    "notZeroValue": notZeroValue == null ? null : notZeroValue,
    "zeroValue": zeroValue == null ? null : zeroValue,

    "invInventoryDTOList": invInventoryDtoList == null ? null : List<dynamic>.from(invInventoryDtoList!.map((x) => x.toJson())),
  };
}


