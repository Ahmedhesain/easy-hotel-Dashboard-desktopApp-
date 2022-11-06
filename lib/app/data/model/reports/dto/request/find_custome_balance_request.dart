// To parse this JSON data, do
//
//     final profitOfItemsSoldRequest = profitOfItemsSoldRequestFromJson(jsonString);

import 'dart:convert';

FindCustomersBalanceRequest profitOfItemsSoldRequestFromJson(String str) => FindCustomersBalanceRequest.fromJson(json.decode(str));


class FindCustomersBalanceRequest {
  FindCustomersBalanceRequest({
    this.branchId,
    this.invInventoryDtoList,
  });

  int ?branchId;
  List<DtoList>? invInventoryDtoList;

  factory FindCustomersBalanceRequest.fromJson(Map<String, dynamic> json) => FindCustomersBalanceRequest(
    branchId: json["branchId"] == null ? null : json["branchId"],
    invInventoryDtoList: json["invInventoryDTOList"] == null ? null : List<DtoList>.from(json["invInventoryDTOList"].map((x) => DtoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "branchId": branchId == null ? null : branchId,
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

