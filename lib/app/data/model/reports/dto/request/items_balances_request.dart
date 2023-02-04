// To parse this JSON data, do
//
//     final profitOfItemsSoldRequest = profitOfItemsSoldRequestFromJson(jsonString);

import 'dart:convert';

import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';



class ItemsBalancesRequest {
  ItemsBalancesRequest({
    this.dateFrom,
    this.dateTo,
    this.branchId,
  });

  DateTime? dateFrom;
  DateTime ?dateTo;
  int? branchId;



  Map<String, dynamic> toJson() => {
    "dateFrom": dateFrom == null ? null : dateFrom?.toIso8601String(),
    "dateTo": dateTo == null ? null : dateTo?.toIso8601String(),
    "branchId": branchId,
  };
}



