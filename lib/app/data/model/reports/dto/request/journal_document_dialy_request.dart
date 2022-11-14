// To parse this JSON data, do
//
//     final journalDocumentDialyRequest = journalDocumentDialyRequestFromJson(jsonString);

import 'dart:convert';

class JournalDocumentDialyRequest {
  JournalDocumentDialyRequest({
    this.documentTypeFrom,
    this.documentTypeTo,
    this.documentNumForm,
    this.documentNumTo,
    this.journalNumForm,
    this.journalNumTo,
    this.userFrom,
    this.userTo,
    this.branchId,
    this.postFlag,
    this.glAccountFrom,
    this.glAccountTo,
    this.costCenterFrom,
    this.costCenterTo,
    this.adminUnitFrom,
    this.adminUnitTo,
    this.periodFrpm,
    this.periodTo,
    this.value,
  });

  String ?documentTypeFrom;
  String ?documentTypeTo;
  int ?documentNumForm;
  int ?documentNumTo;
  int ?journalNumForm;
  int ?journalNumTo;
  String? userFrom;
  String? userTo;
  int ?branchId;
  String? postFlag;
  int ?glAccountFrom;
  int ?glAccountTo;
  int ?costCenterFrom;
  int ?costCenterTo;
  String? adminUnitFrom;
  String? adminUnitTo;
  DateTime? periodFrpm;
  DateTime? periodTo;
  String ?value;

  factory JournalDocumentDialyRequest.fromRawJson(String str) => JournalDocumentDialyRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JournalDocumentDialyRequest.fromJson(Map<String, dynamic> json) => JournalDocumentDialyRequest(
    documentTypeFrom: json["documentTypeFrom"] == null ? null : json["documentTypeFrom"],
    documentTypeTo: json["documentTypeTo"] == null ? null : json["documentTypeTo"],
    documentNumForm: json["documentNumForm"] == null ? null : json["documentNumForm"],
    documentNumTo: json["documentNumTo"] == null ? null : json["documentNumTo"],
    journalNumForm: json["journalNumForm"] == null ? null : json["journalNumForm"],
    journalNumTo: json["journalNumTo"] == null ? null : json["journalNumTo"],
    userFrom: json["userFrom"] == null ? null : json["userFrom"],
    userTo: json["userTo"] == null ? null : json["userTo"],
    branchId: json["branchId"] == null ? null : json["branchId"],
    postFlag: json["postFlag"] == null ? null : json["postFlag"],
    glAccountFrom: json["glAccountFrom"] == null ? null : json["glAccountFrom"],
    glAccountTo: json["glAccountTo"] == null ? null : json["glAccountTo"],
    costCenterFrom: json["costCenterFrom"] == null ? null : json["costCenterFrom"],
    costCenterTo: json["costCenterTo"] == null ? null : json["costCenterTo"],
    adminUnitFrom: json["adminUnitFrom"] == null ? null : json["adminUnitFrom"],
    adminUnitTo: json["adminUnitTo"] == null ? null : json["adminUnitTo"],
    periodFrpm: json["periodFrpm"] == null ? null : DateTime.parse(json["periodFrpm"]),
    periodTo: json["periodTo"] == null ? null : DateTime.parse(json["periodTo"]),
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "documentTypeFrom": documentTypeFrom == null ? null : documentTypeFrom,
    "documentTypeTo": documentTypeTo == null ? null : documentTypeTo,
    "documentNumForm": documentNumForm == null ? null : documentNumForm,
    "documentNumTo": documentNumTo == null ? null : documentNumTo,
    "journalNumForm": journalNumForm == null ? null : journalNumForm,
    "journalNumTo": journalNumTo == null ? null : journalNumTo,
    "userFrom": userFrom == null ? null : userFrom,
    "userTo": userTo == null ? null : userTo,
    "branchId": branchId == null ? null : branchId,
    "postFlag": postFlag == null ? null : postFlag,
    "glAccountFrom": glAccountFrom == null ? null : glAccountFrom,
    "glAccountTo": glAccountTo == null ? null : glAccountTo,
    "costCenterFrom": costCenterFrom == null ? null : costCenterFrom,
    "costCenterTo": costCenterTo == null ? null : costCenterTo,
    "adminUnitFrom": adminUnitFrom == null ? null : adminUnitFrom,
    "adminUnitTo": adminUnitTo == null ? null : adminUnitTo,
    "periodFrpm": periodFrpm == null ? null : periodFrpm?.toIso8601String(),
    "periodTo": periodTo == null ? null : periodTo?.toIso8601String(),
    "value": value == null ? null : value,
  };
}
