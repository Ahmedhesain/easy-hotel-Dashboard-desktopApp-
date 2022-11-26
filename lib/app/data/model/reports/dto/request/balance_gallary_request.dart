// To parse this JSON data, do
//
//     final profitOfItemsSoldRequest = profitOfItemsSoldRequestFromJson(jsonString);

import 'dart:convert';

import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';

BalanceGallaryRequest profitOfItemsSoldRequestFromJson(String str) => BalanceGallaryRequest.fromJson(json.decode(str));


class BalanceGallaryRequest {
  BalanceGallaryRequest({
    this.dateFrom,
    this.dateTo,
    this.invInventoryDtoList,
    this.branchId
  });

  DateTime? dateFrom;
  DateTime ?dateTo;
  List<DtoListName>? invInventoryDtoList;
  int?branchId;

  factory BalanceGallaryRequest.fromJson(Map<String, dynamic> json) => BalanceGallaryRequest(
    dateFrom: json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
    dateTo: json["dateTo"] == null ? null : DateTime.parse(json["dateTo"]),

    invInventoryDtoList: json["invInventoryDTOList"] == null ? null : List<DtoListName>.from(json["invInventoryDTOList"].map((x) => DtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "branchId": branchId,
    "dateFrom": dateFrom == null ? null : dateFrom?.toIso8601String(),
    "dateTo": dateTo == null ? null : dateTo?.toIso8601String(),
    "invInventoryDTOList": invInventoryDtoList == null ? null : List<dynamic>.from(invInventoryDtoList!.map((x) => x.toJson())),
  };
}



