// To parse this JSON data, do
//
//     final glaccountModel = glaccountModelFromJson(jsonString);

import 'dart:convert';

class GlAccountResponse {
  GlAccountResponse({
    this.type,
    this.createdBy,
    this.createdDate,
    this.id,
    this.index,
    this.markEdit,
    this.accClass,
    this.accGroup,
    this.accNumber,
    this.administrativeUnit,
    this.assistantAcc,
    this.costCenter,
    this.currencyId,
    this.levelAcc,
    this.name,
    this.shotCode,
    this.status,
  });

  int ?type;
  int ?createdBy;
  DateTime? createdDate;
  int? id;
  int ?index;
  bool ?markEdit;
  String? accClass;
  String ?accGroup;
  int ?accNumber;
  String? administrativeUnit;
  String ?assistantAcc;
  String ?costCenter;
  int ?currencyId;
  int ?levelAcc;
  String? name;
  String? shotCode;
  bool ?status;

  static List<GlAccountResponse> fromList(List<dynamic> json) => List<GlAccountResponse>.from(json.map((e) => GlAccountResponse.fromJson(e)));

  factory GlAccountResponse.fromJson(Map<String, dynamic> json) => GlAccountResponse(
    type: json["type"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    id: json["id"],
    index: json["index"],
    markEdit: json["markEdit"],
    accClass: json["accClass"],
    accGroup: json["accGroup"],
    accNumber: json["accNumber"],
    administrativeUnit: json["administrativeUnit"],
    assistantAcc: json["assistantAcc"],
    costCenter: json["costCenter"],
    currencyId: json["currencyId"],
    levelAcc: json["levelAcc"],
    name: json["name"],
    shotCode: json["shotCode"] == null ? null : json["shotCode"].toString(),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "createdBy": createdBy,
    "createdDate": createdDate == null ? null : createdDate!.toIso8601String(),
    "id": id,
    "index": index,
    "markEdit": markEdit,
    "accClass": accClass,
    "accGroup": accGroup,
    "accNumber": accNumber,
    "administrativeUnit": administrativeUnit,
    "assistantAcc": assistantAcc,
    "costCenter": costCenter,
    "currencyId": currencyId,
    "levelAcc": levelAcc,
    "name": name,
    "shotCode": shotCode,
    "status": status,
  };

  @override
  String toString() => "$name";
}
