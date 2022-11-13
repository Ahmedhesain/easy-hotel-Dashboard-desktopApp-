// To parse this JSON data, do
//
//     final journalDocumentDialyResponse = journalDocumentDialyResponseFromJson(jsonString);

import 'dart:convert';

class JournalDocumentDialyResponse {
  JournalDocumentDialyResponse({
    this.type,
    this.branchId,
    this.serial,
    this.generalDate,
    this.generalDocument,
    this.generalNumber,
    this.generalStatement,
    this.generalType,
    this.glYear,
    this.postFlag,
  });

  String? type;
  int ?branchId;
  int ?serial;
  DateTime? generalDate;
  int ?generalDocument;
  int ?generalNumber;
  String ?generalStatement;
  int ?generalType;
  int ?glYear;
  bool? postFlag;


  static List<JournalDocumentDialyResponse> fromList(List<dynamic> json) => List.from(json.map((e) => JournalDocumentDialyResponse.fromJson(e)));

  factory JournalDocumentDialyResponse.fromRawJson(String str) => JournalDocumentDialyResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JournalDocumentDialyResponse.fromJson(Map<String, dynamic> json) => JournalDocumentDialyResponse(
    type: json["type"] == null ? null : json["type"],
    branchId: json["branchId"] == null ? null : json["branchId"],
    serial: json["serial"] == null ? null : json["serial"],
    generalDate: json["generalDate"] == null ? null : DateTime.parse(json["generalDate"]),
    generalDocument: json["generalDocument"] == null ? null : json["generalDocument"],
    generalNumber: json["generalNumber"] == null ? null : json["generalNumber"],
    generalStatement: json["generalStatement"] == null ? null : json["generalStatement"],
    generalType: json["generalType"] == null ? null : json["generalType"],
    glYear: json["glYear"] == null ? null : json["glYear"],
    postFlag: json["postFlag"] == null ? null : json["postFlag"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "branchId": branchId == null ? null : branchId,
    "serial": serial == null ? null : serial,
    "generalDate": generalDate == null ? null : generalDate?.toIso8601String(),
    "generalDocument": generalDocument == null ? null : generalDocument,
    "generalNumber": generalNumber == null ? null : generalNumber,
    "generalStatement": generalStatement == null ? null : generalStatement,
    "generalType": generalType == null ? null : generalType,
    "glYear": glYear == null ? null : glYear,
    "postFlag": postFlag == null ? null : postFlag,
  };
}
