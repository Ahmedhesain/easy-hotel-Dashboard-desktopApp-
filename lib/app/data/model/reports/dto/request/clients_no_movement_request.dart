// To parse this JSON data, do
//
//     final profitOfItemsSoldRequest = profitOfItemsSoldRequestFromJson(jsonString);

import 'dart:convert';

ClientsNoMovementRequest profitOfItemsSoldRequestFromJson(String str) => ClientsNoMovementRequest.fromJson(json.decode(str));


class ClientsNoMovementRequest {
  ClientsNoMovementRequest({
    this.branchId,
    this.dateFrom,
    this.invInventoryDtoList,
  });

  int ?branchId;
  DateTime? dateFrom;
  List<DtoList>? invInventoryDtoList;

  factory ClientsNoMovementRequest.fromJson(Map<String, dynamic> json) => ClientsNoMovementRequest(
    branchId: json["branchId"] == null ? null : json["branchId"],
    dateFrom: json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
    invInventoryDtoList: json["invInventoryDTOList"] == null ? null : List<DtoList>.from(json["invInventoryDTOList"].map((x) => DtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "branchId": branchId == null ? null : branchId,
    "dateFrom": dateFrom == null ? null : dateFrom?.toIso8601String(),
    "invInventoryDTOList": invInventoryDtoList == null ? null : List<dynamic>.from(invInventoryDtoList!.map((x) => x.toJson())),
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

