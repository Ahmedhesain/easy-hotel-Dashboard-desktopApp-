// To parse this JSON data, do
//
//     final galleryResponse = galleryResponseFromJson(jsonString);

import 'dart:convert';

class GalleryResponse {
  GalleryResponse({
    this.type,
    this.branchId,
    this.companyId,
    this.createdBy,
    this.createdDate,
    this.id,
    this.index,
    this.markEdit,
    this.accountId,
    this.code,
    this.costAccount,
    this.costCenterId,
    this.customerAccount,
    this.daribaValue,
    this.invName,
    this.invType,
    this.name,
    this.phone,
    this.runningAccount,
    this.segilValue,
    this.sellerName,
  });

  final String? type;
  final int? branchId;
  final int? companyId;
  final int? createdBy;
  final DateTime? createdDate;
  final int? id;
  final int? index;
  final bool? markEdit;
  final AccountId? accountId;
  final String? code;
  final AccountId? costAccount;
  final CostCenterId? costCenterId;
  final AccountId? customerAccount;
  final String? daribaValue;
  final int? invName;
  final int? invType;
  final String? name;
  final String? phone;
  final AccountId? runningAccount;
  final String? segilValue;
  final String? sellerName;

  static List<GalleryResponse> fromList(List<dynamic> json) => List<GalleryResponse>.from(json.map((e) => GalleryResponse.fromJson(e)));

  factory GalleryResponse.fromJson(Map<String, dynamic> json) => GalleryResponse(
    type: json["type"],
    branchId: json["branchId"],
    companyId: json["companyId"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"] == null?null:DateTime.parse(json["createdDate"]),
    id: json["id"],
    index: json["index"],
    markEdit: json["markEdit"],
    accountId: json["accountId"] == null?null:AccountId.fromJson(json["accountId"]),
    code: json["code"],
    costAccount: json["costAccount"] == null?null:AccountId.fromJson(json["costAccount"]),
    costCenterId: json["costCenterId"] == null?null:CostCenterId.fromJson(json["costCenterId"]),
    customerAccount: json["customerAccount"] == null?null:AccountId.fromJson(json["customerAccount"]),
    daribaValue: json["daribaValue"],
    invName: json["invName"],
    invType: json["invType"],
    name: json["name"],
    phone: json["phone"],
    runningAccount: json["costAccount"] == null?null:AccountId.fromJson(json["runningAccount"]),
    segilValue: json["segilValue"],
    sellerName: json["sellerName"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "branchId": branchId,
    "companyId": companyId,
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "id": id,
    "index": index,
    "markEdit": markEdit,
    "accountId": accountId?.toJson(),
    "code": code,
    "costAccount": costAccount?.toJson(),
    "costCenterId": costCenterId?.toJson(),
    "customerAccount": customerAccount?.toJson(),
    "daribaValue": daribaValue,
    "invName": invName,
    "invType": invType,
    "name": name,
    "phone": phone,
    "runningAccount": runningAccount?.toJson(),
    "segilValue": segilValue,
    "sellerName": sellerName,
  };
}

class AccountId {
  AccountId({
    this.id,
    this.markEdit,
    this.accNumber,
    this.name,
    this.status,
  });

  final int? id;
  final bool? markEdit;
  final int? accNumber;
  final String? name;
  final bool? status;


  factory AccountId.fromJson(Map<String, dynamic> json) => AccountId(
    id: json["id"],
    markEdit: json["markEdit"],
    accNumber: json["accNumber"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "markEdit": markEdit,
    "accNumber": accNumber,
    "name": name,
    "status": status,
  };
}

class CostCenterId {
  CostCenterId({
    this.id,
    this.markEdit,
    this.code,
    this.name,
  });

  final int? id;
  final bool? markEdit;
  final int? code;
  final String? name;

  factory CostCenterId.fromJson(Map<String, dynamic> json) => CostCenterId(
    id: json["id"],
    markEdit: json["markEdit"],
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "markEdit": markEdit,
    "code": code,
    "name": name,
  };
}
