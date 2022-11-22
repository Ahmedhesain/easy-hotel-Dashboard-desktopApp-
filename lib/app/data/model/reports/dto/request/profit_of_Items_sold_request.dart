// To parse this JSON data, do
//
//     final profitOfItemsSoldRequest = profitOfItemsSoldRequestFromJson(jsonString);

import 'dart:convert';

ProfitOfItemsSoldRequest profitOfItemsSoldRequestFromJson(String str) => ProfitOfItemsSoldRequest.fromJson(json.decode(str));

String profitOfItemsSoldRequestToJson(ProfitOfItemsSoldRequest data) => json.encode(data.toJson());

class ProfitOfItemsSoldRequest {
  ProfitOfItemsSoldRequest({
    this.branchId,
    this.dateFrom,
    this.dateTo,
    this.invType,
    this.invoiceType,
    this.invInventoryDtoList,
    this.proGroupDtoList,
  });

  int ?branchId;
  DateTime? dateFrom;
  DateTime ?dateTo;
  int ?invType;
  int? invoiceType;
  List<DtoList>? invInventoryDtoList;
  List<DtoList>? proGroupDtoList;

  factory ProfitOfItemsSoldRequest.fromJson(Map<String, dynamic> json) => ProfitOfItemsSoldRequest(
    branchId: json["branchId"] == null ? null : json["branchId"],
    dateFrom: json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
    dateTo: json["dateTo"] == null ? null : DateTime.parse(json["dateTo"]),
    invType: json["invType"] == null ? null : json["invType"],
    invoiceType: json["invoiceType"] == null ? null : json["invoiceType"],
    invInventoryDtoList: json["invInventoryDTOList"] == null ? null : List<DtoList>.from(json["invInventoryDTOList"].map((x) => DtoList.fromJson(x))),
    proGroupDtoList: json["proGroupDTOList"] == null ? null : List<DtoList>.from(json["proGroupDTOList"].map((x) => DtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "branchId": branchId == null ? null : branchId,
    "dateFrom": dateFrom == null ? null : dateFrom?.toIso8601String(),
    "dateTo": dateTo == null ? null : dateTo?.toIso8601String(),
    "invType": invType == null ? null : invType,
    "invoiceType": invoiceType == null ? null : invoiceType,
    "invInventoryDTOList": invInventoryDtoList == null ? null : List<dynamic>.from(invInventoryDtoList!.map((x) => x.toJson())),
    "proGroupDTOList": proGroupDtoList == null ? null : List<dynamic>.from(proGroupDtoList!.map((x) => x.toJson())),
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
class AllGroupsRequest {
  AllGroupsRequest({
    required this.id,
    required this.branchId,



  });
  final int id;
  final int branchId;




  Map<String, dynamic> toJson(){
    return {

      "id": id,
      "branchId": branchId,

    };
  }

}

