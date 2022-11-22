// To parse this JSON data, do
//
//     final clientsNoMovementRequest = clientsNoMovementRequestFromJson(jsonString);

import 'dart:convert';

import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';

ClientsNoMovementRequest clientsNoMovementRequestFromJson(String str) => ClientsNoMovementRequest.fromJson(json.decode(str));

String clientsNoMovementRequestToJson(ClientsNoMovementRequest data) => json.encode(data.toJson());

class ClientsNoMovementRequest {
  ClientsNoMovementRequest({
    this.invInventoryDtoList,
    this.branchId,
    this.dateFrom,
  });

  List<DtoList>? invInventoryDtoList;
  int ?branchId;
  DateTime? dateFrom;

  factory ClientsNoMovementRequest.fromJson(Map<String, dynamic> json) => ClientsNoMovementRequest(
    invInventoryDtoList: json["invInventoryDTOList"] == null ? null : List<DtoList>.from(json["invInventoryDTOList"].map((x) => DtoList.fromJson(x))),
    branchId: json["branchId"] == null ? null : json["branchId"],
    dateFrom: json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
  );

  Map<String, dynamic> toJson() => {
    "invInventoryDTOList": invInventoryDtoList == null ? null : List<dynamic>.from(invInventoryDtoList!.map((x) => x.toJson())),
    "branchId": branchId == null ? null : branchId,
    "dateFrom": dateFrom == null ? null : dateFrom?.toIso8601String(),
  };
}

class GallarySellected {
  GallarySellected({
    this.id,
  });

  int ?id;

  factory GallarySellected.fromJson(Map<String, dynamic> json) => GallarySellected(
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
  };
}
