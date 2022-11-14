// To parse this JSON data, do
//
//     final profitOfItemsSoldRequest = profitOfItemsSoldRequestFromJson(jsonString);

import 'dart:convert';

import 'package:toby_bills/app/data/model/reports/dto/request/find_custome_balance_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';



class InvoiceMovementRequest {
  InvoiceMovementRequest({
    this.branchId,
    this.dateFrom,
    this.dateTo,
    this.invoiceFrom,
    this.invoiceTo,
    this.invoiceType,
    this.invInventoryDtoList,
  });

  int ?branchId;
  DateTime? dateFrom;
  DateTime ?dateTo;
  int?invoiceFrom;
  int?invoiceTo;
  int?invoiceType;
  List<DtoList>? invInventoryDtoList;

  factory InvoiceMovementRequest.fromJson(Map<String, dynamic> json) => InvoiceMovementRequest(
    branchId: json["branchId"] == null ? null : json["branchId"],
    dateFrom: json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
    dateTo: json["dateTo"] == null ? null : DateTime.parse(json["dateTo"]),
    invoiceFrom: json["invoiceFrom"] == null ? null : json["invoiceFrom"],
    invoiceTo: json["invoiceTo"] == null ? null : json["invoiceTo"],
    invoiceType: json["invoiceType"] == null ? null : json["invoiceType"],
    invInventoryDtoList: json["invInventoryDTOList"] == null ? null : List<DtoList>.from(json["invInventoryDTOList"].map((x) => DtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "branchId": branchId == null ? null : branchId,
    "dateFrom": dateFrom == null ? null : dateFrom?.toIso8601String(),
    "dateTo": dateTo == null ? null : dateTo?.toIso8601String(),
    "invoiceTo": invoiceTo == null ? null : invoiceTo,
    "invoiceFrom": invoiceFrom == null ? null : invoiceFrom,
    "invoiceType": invoiceType == null ? null : invoiceType,
    "invInventoryDTOList": invInventoryDtoList == null ? null : List<dynamic>.from(invInventoryDtoList!.map((x) => x.toJson())),
  };
}


