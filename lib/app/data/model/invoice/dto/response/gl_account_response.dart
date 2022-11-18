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
    type: json["type"] == null ? null : json["type"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    id: json["id"] == null ? null : json["id"],
    index: json["index"] == null ? null : json["index"],
    markEdit: json["markEdit"] == null ? null : json["markEdit"],
    accClass: json["accClass"] == null ? null : json["accClass"],
    accGroup: json["accGroup"] == null ? null : json["accGroup"],
    accNumber: json["accNumber"] == null ? null : json["accNumber"],
    administrativeUnit: json["administrativeUnit"] == null ? null : json["administrativeUnit"],
    assistantAcc: json["assistantAcc"] == null ? null : json["assistantAcc"],
    costCenter: json["costCenter"] == null ? null : json["costCenter"],
    currencyId: json["currencyId"] == null ? null : json["currencyId"],
    levelAcc: json["levelAcc"] == null ? null : json["levelAcc"],
    name: json["name"] == null ? null : json["name"],
    shotCode: json["shotCode"] == null ? null : json["shotCode"].toString(),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "createdBy": createdBy == null ? null : createdBy,
    "createdDate": createdDate == null ? null : createdDate!.toIso8601String(),
    "id": id == null ? null : id,
    "index": index == null ? null : index,
    "markEdit": markEdit == null ? null : markEdit,
    "accClass": accClass == null ? null : accClass,
    "accGroup": accGroup == null ? null : accGroup,
    "accNumber": accNumber == null ? null : accNumber,
    "administrativeUnit": administrativeUnit == null ? null : administrativeUnit,
    "assistantAcc": assistantAcc == null ? null : assistantAcc,
    "costCenter": costCenter == null ? null : costCenter,
    "currencyId": currencyId == null ? null : currencyId,
    "levelAcc": levelAcc == null ? null : levelAcc,
    "name": name == null ? null : name,
    "shotCode": shotCode == null ? null : shotCode,
    "status": status == null ? null : status,
  };

  @override
  String toString() => "$name";
}
