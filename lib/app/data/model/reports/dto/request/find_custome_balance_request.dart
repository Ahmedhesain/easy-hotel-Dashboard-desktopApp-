// To parse this JSON data, do
//
//     final profitOfItemsSoldRequest = profitOfItemsSoldRequestFromJson(jsonString);

import 'dart:convert';

import 'package:toby_bills/app/data/model/reports/dto/request/clients_no_movement_request.dart';

FindCustomersBalanceRequest profitOfItemsSoldRequestFromJson(String str) => FindCustomersBalanceRequest.fromJson(json.decode(str));


class FindCustomersBalanceRequest {
  FindCustomersBalanceRequest({
    this.branchId,
    this.gallarySellected,
  });

  int ?branchId;
  GallarySellected ?gallarySellected;

  factory FindCustomersBalanceRequest.fromJson(Map<String, dynamic> json) => FindCustomersBalanceRequest(
    branchId: json["branchId"] == null ? null : json["branchId"],
    gallarySellected: json["gallarySellected"] == null ? null : GallarySellected.fromJson(json["gallarySellected"]),
  );

  Map<String, dynamic> toJson() => {
    "branchId": branchId == null ? null : branchId,
    "gallarySellected": gallarySellected == null ? null : gallarySellected!.toJson(),
  };
}

class DtoList {
  DtoList({
    this.id,
  });

  int? id;

  factory DtoList.fromJson(Map<String, dynamic> json) => DtoList(
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
  };
}

