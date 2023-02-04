// To parse this JSON data, do
//
//     final generaljournalModel = generaljournalModelFromJson(jsonString);

import 'dart:convert';

import 'generaljournaldetail_model.dart';

class GeneralJournalModel {
  GeneralJournalModel({
    this.branchId,
    this.createdBy,
    this.createdDate,
    this.id,
    this.index,
    this.markEdit,
    this.serial,
    this.generaljournalModelCreatedBy,
    this.detailDtoList,
    this.detailList,
    this.generalData,
    this.generalDecument,
    this.generalNumber,
    this.generalStatement,
    this.postFlag,
    this.userModifyAbility,
    this.companyId,
    this.glYearId,
    this.generalTypeId,
    this.generalTypeName,
this.createdByName

  });

  int? branchId;
  int? createdBy ;
  DateTime? createdDate;
  int? id;
  int? index;
  bool? markEdit;
  int? serial;
  CreatedBy? generaljournalModelCreatedBy;
  List<GenralJournalDetailModel>? detailDtoList = [];
  List<dynamic> ?detailList;
  DateTime ?generalData;
  int ?generalDecument;
  int ?generalNumber;
  String? generalStatement;
  bool? postFlag;
  bool? userModifyAbility;
  int? companyId;
  int? glYearId;
  int? generalTypeId;
  String? generalTypeName ;
  String? createdByName;



  factory GeneralJournalModel.fromJson(Map<String, dynamic> json) => GeneralJournalModel(
    branchId: json["branchId"] == null ? null : json["branchId"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    id: json["id"] == null ? null : json["id"],
    index: json["index"] == null ? null : json["index"],
    markEdit: json["markEdit"] == null ? null : json["markEdit"],
    serial: json["serial"] == null ? null : json["serial"],
    generaljournalModelCreatedBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
    detailDtoList: json["detailDTOList"] == null ? [] : List<GenralJournalDetailModel>.from(json["detailDTOList"].map((x) => GenralJournalDetailModel.fromJson(x))),
    detailList: json["detailList"] == null ? null : List<dynamic>.from(json["detailList"].map((x) => x)),
    generalData: json["generalData"] == null ? null : DateTime.parse(json["generalData"]),
    generalDecument: json["generalDecument"] == null ? null : json["generalDecument"],
    generalNumber: json["generalNumber"] == null ? null : json["generalNumber"],
    generalStatement: json["generalStatement"] == null ? null : json["generalStatement"],
    postFlag: json["post_flag"] == null ? null : json["post_flag"],
    userModifyAbility: json["userModifyAbility"] == null ? null : json["userModifyAbility"],
    companyId: json["companyId"] == null ? null : json["companyId"],
    glYearId: json["glYearId"] == null ? null : json["glYearId"],
    generalTypeId: json["generalTypeId"] == null ? null : json["generalTypeId"],
    generalTypeName: json["generalTypeName"] == null ? null : json["generalTypeName"],
    createdByName: json["createdByName"] == null ? null : json["createdByName"],
  );

  Map<String, dynamic> toJson() => {
    "branchId": branchId == null ? null : branchId,
    "createdBy": createdBy == null ? null : createdBy,
    "createdDate": createdDate == null ? null : createdDate!.toIso8601String(),
    "id": id == null ? null : id,
    "index": index == null ? null : index,
    "markEdit": markEdit == null ? null : markEdit,
    "serial": serial == null ? null : serial,
    "created_by": generaljournalModelCreatedBy == null ? null : generaljournalModelCreatedBy!.toJson(),
    "detailDTOList": detailDtoList == null ? null : List<GenralJournalDetailModel>.from(detailDtoList!.map((x) => x)),
    "detailList": detailList == null ? null : List<dynamic>.from(detailList!.map((x) => x)),
    "generalData": generalData == null ? null : generalData!.toIso8601String(),
    "generalDecument": generalDecument == null ? null : generalDecument,
    "generalNumber": generalNumber == null ? null : generalNumber,
    "generalStatement": generalStatement == null ? null : generalStatement,
    "post_flag": postFlag == null ? null : postFlag,
    "userModifyAbility": userModifyAbility == null ? null : userModifyAbility,
    "companyId": companyId == null ? null : companyId,
    "glYearId": glYearId == null ? null : glYearId,
    "generalTypeId": generalTypeId == null ? null : generalTypeId,
  };
}

class CreatedBy {
  CreatedBy();

  factory CreatedBy.fromRawJson(String str) => CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
  );

  Map<String, dynamic> toJson() => {
  };
}
