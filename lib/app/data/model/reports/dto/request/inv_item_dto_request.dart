// To parse this JSON data, do
//
//     final invItemDtoRequest = invItemDtoRequestFromJson(jsonString);

import 'dart:convert';

InvItemDtoRequest invItemDtoRequestFromJson(String str) => InvItemDtoRequest.fromJson(json.decode(str));

String invItemDtoRequestToJson(InvItemDtoRequest data) => json.encode(data.toJson());

class InvItemDtoRequest {
  InvItemDtoRequest({
    this.branchId,
    this.dateFrom,
    this.isUsed,
    this.lastCost,
    this.itemNatural,
    this.proGroupDtoList,
  });

  int ?branchId;
  DateTime? dateFrom;
  bool ?isUsed;
  String? lastCost;
  int ?itemNatural;
  List<ProGroupDtoList>? proGroupDtoList;

  factory InvItemDtoRequest.fromJson(Map<String, dynamic> json) => InvItemDtoRequest(
    branchId: json["branchId"] == null ? null : json["branchId"],
    dateFrom: json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
    isUsed: json["isUsed"] == null ? null : json["isUsed"],
    lastCost: json["lastCost"] == null ? null : json["lastCost"],
    itemNatural: json["itemNatural"] == null ? null : json["itemNatural"],
    proGroupDtoList: json["proGroupDTOList"] == null ? null : List<ProGroupDtoList>.from(json["proGroupDTOList"].map((x) => ProGroupDtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "branchId": branchId == null ? null : branchId,
    "dateFrom": dateFrom == null ? null : dateFrom?.toIso8601String(),
    "isUsed": isUsed == null ? null : isUsed,
    "lastCost": lastCost == null ? null : lastCost,
    "itemNatural": itemNatural == null ? null : itemNatural,
    "proGroupDTOList": proGroupDtoList == null ? null : List<dynamic>.from(proGroupDtoList!.map((x) => x.toJson())),
  };
}

class ProGroupDtoList {
  ProGroupDtoList({
    this.id,
  });

  int ?id;

  factory ProGroupDtoList.fromJson(Map<String, dynamic> json) => ProGroupDtoList(
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
  };
}
