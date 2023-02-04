// To parse this JSON data, do
//
//     final profitOfItemsSoldRequest = profitOfItemsSoldRequestFromJson(jsonString);

import 'dart:convert';

import 'package:toby_bills/app/data/model/reports/dto/request/find_custome_balance_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';



class CategoriesItemsRequest {
  CategoriesItemsRequest({
    this.branchId,
    this.dateFrom,
    this.remainBoolean,
    this.notZeroValue,
    this.zeroValue,
    this.remain,
    this.invInventoryDtoList,
  });

  int ?branchId;
  DateTime? dateFrom;
  bool ?remainBoolean;
  bool ?notZeroValue;
  bool ?zeroValue;

  int ?remain;
  List<DtoList>? invInventoryDtoList;

  factory CategoriesItemsRequest.fromJson(Map<String, dynamic> json) => CategoriesItemsRequest(
    branchId: json["branchId"] == null ? null : json["branchId"],
    dateFrom: json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
    remainBoolean: json["remainBoolean"] == null ? null : json["remainBoolean"],
    notZeroValue: json["notZeroValue"] == null ? null : json["notZeroValue"],
    zeroValue: json["zeroValue"] == null ? null : json["zeroValue"],

    remain: json["remain"] == null ? null : json["remain"],
    invInventoryDtoList: json["invInventoryDTOList"] == null ? null : List<DtoList>.from(json["invInventoryDTOList"].map((x) => DtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "branchId": branchId == null ? null : branchId,
    "dateFrom": dateFrom == null ? null : dateFrom?.toIso8601String(),
    "remainBoolean": remainBoolean == null ? null : remainBoolean,
    "notZeroValue": notZeroValue == null ? null : notZeroValue,
    "zeroValue": zeroValue == null ? null : zeroValue,

    "remain": remain == null ? null : remain,
    "invInventoryDTOList": invInventoryDtoList == null ? null : List<dynamic>.from(invInventoryDtoList!.map((x) => x.toJson())),
  };
}


