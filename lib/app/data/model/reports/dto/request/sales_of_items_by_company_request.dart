// To parse this JSON data, do
//
//     final profitOfItemsSoldRequest = profitOfItemsSoldRequestFromJson(jsonString);

import 'dart:convert';

import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';

SalesOfItemsByCompanyRequest profitOfItemsSoldRequestFromJson(String str) => SalesOfItemsByCompanyRequest.fromJson(json.decode(str));


class SalesOfItemsByCompanyRequest {
  SalesOfItemsByCompanyRequest({
    this.dateFrom,
    this.dateTo,
    this.invInventoryDtoList,
  });

  DateTime? dateFrom;
  DateTime ?dateTo;
  List<DtoList>? invInventoryDtoList;

  factory SalesOfItemsByCompanyRequest.fromJson(Map<String, dynamic> json) => SalesOfItemsByCompanyRequest(
    dateFrom: json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
    dateTo: json["dateTo"] == null ? null : DateTime.parse(json["dateTo"]),

    invInventoryDtoList: json["invInventoryDTOList"] == null ? null : List<DtoList>.from(json["invInventoryDTOList"].map((x) => DtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "dateFrom": dateFrom == null ? null : dateFrom?.toIso8601String(),
    "dateTo": dateTo == null ? null : dateTo?.toIso8601String(),
    "invInventoryDTOList": invInventoryDtoList == null ? null : List<dynamic>.from(invInventoryDtoList!.map((x) => x.toJson())),
  };
}



