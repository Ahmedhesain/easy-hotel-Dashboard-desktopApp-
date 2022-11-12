// To parse this JSON data, do
//
//     final genraljournalitemModel = genraljournalitemModelFromJson(jsonString);

import 'dart:convert';

class GenralJournalDetailModel {
  GenralJournalDetailModel({
    this.branchId,
    this.createdBy,
    this.createdDate,
    this.id,
    this.index,
    this.serial,
    this.costCenter,
    this.currency,
    this.debitAmount,
    this.debitAmountLocal,
    this.creditAmount,
    this.creditAmountLocal,
    this.discribtion,
    this.generalJournal,
    this.glAccount,
    this.rate,
    this.glAccountName,
    this.glAccountNumber,
    this.glCostCenterName,
    this.glCostCenterNumber,
    this.companyId,
    this.modifiedBy,
    this.modificationDate,
    this.statementEdit = false,
    this.creditEdit = false,
    this.debitEdit = false
  });

  int? branchId;
  int? createdBy;
  DateTime? createdDate;
  int? id;
  int? index;
  int? serial;
  int? costCenter;
  int? currency;
  num? debitAmount;
  num? debitAmountLocal;
  String? discribtion;
  int? generalJournal;
  int? glAccount;
  num? rate;
  String? glAccountName;
  String? glAccountNumber;
  String? glCostCenterName;
  String? glCostCenterNumber;
  int? companyId;
  int? modifiedBy;
  DateTime? modificationDate;
  num? creditAmount;
  num? creditAmountLocal;
  bool? creditEdit = false ;
  bool? debitEdit = false ;
  bool? statementEdit = false ;
  factory GenralJournalDetailModel.fromRawJson(String str) =>
      GenralJournalDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GenralJournalDetailModel.fromJson(Map<String, dynamic> json) =>
      GenralJournalDetailModel(
        branchId: json["branchId"] == null ? null : json["branchId"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        createdDate: json["createdDate"] == null? null: DateTime.parse(json["createdDate"]),
        id: json["id"] == null ? null : json["id"],
        index: json["index"] == null ? null : json["index"],
        serial: json["serial"] == null ? null : json["serial"],
        costCenter: json["costCenter"] == null ? null : json["costCenter"],
        currency: json["currency"] == null ? null : json["currency"],
        debitAmount: json["debitAmount"] == null ? null : json["debitAmount"],
        debitAmountLocal:
            json["debitAmountLocal"] == null ? null : json["debitAmountLocal"],
        discribtion: json["discribtion"] == null ? null : json["discribtion"],
        generalJournal:
            json["generalJournal"] == null ? null : json["generalJournal"],
        glAccount: json["glAccount"] == null ? null : json["glAccount"],
        rate: json["rate"] == null ? null : json["rate"],
        glAccountName:
            json["glAccountName"] == null ? null : json["glAccountName"],
        glAccountNumber:
            json["glAccountNumber"] == null ? null : json["glAccountNumber"],
        glCostCenterName:
            json["glCostCenterName"] == null ? null : json["glCostCenterName"],
        glCostCenterNumber: json["glCostCenterNumber"] == null
            ? null
            : json["glCostCenterNumber"],
        companyId: json["companyId"] == null ? null : json["companyId"],
        modifiedBy: json["modifiedBy"] == null ? null : json["modifiedBy"],
        modificationDate: json["modificationDate"] == null
            ? null
            : DateTime.parse(json["modificationDate"]),
        creditAmount:
            json["creditamount"] == null ? null : json["creditamount"],
        creditAmountLocal: json["creditAmountLocal"] == null
            ? null
            : json["creditAmountLocal"],
        creditEdit : false ,
        debitEdit : false ,
        statementEdit : false ,
      );

  Map<String, dynamic> toJson() => {
        "branchId": branchId == null ? null : branchId,
        "createdBy": createdBy == null ? null : createdBy,
        "createdDate":
            createdDate == null ? null : createdDate!.toIso8601String(),
        "id": id == null ? null : id,
        "index": index == null ? null : index,
        "serial": serial == null ? null : serial,
        "costCenter": costCenter == null ? null : costCenter,
        "currency": currency == null ? null : currency,
        "debitAmount": debitAmount == null ? null : debitAmount,
        "creditamount": creditAmount == null ? null : creditAmount,
        "debitAmountLocal": debitAmountLocal == null ? null : debitAmountLocal,
        "discribtion": discribtion == null ? null : discribtion,
        "generalJournal": generalJournal == null ? null : generalJournal,
        "glAccount": glAccount == null ? null : glAccount,
        "rate": rate == null ? null : rate,
        "glAccountName": glAccountName == null ? null : glAccountName,
        "glAccountNumber": glAccountNumber == null ? null : glAccountNumber,
        "glCostCenterName": glCostCenterName == null ? null : glCostCenterName,
        "glCostCenterNumber":
            glCostCenterNumber == null ? null : glCostCenterNumber,
        "companyId": companyId == null ? null : companyId,
        "modifiedBy": modifiedBy == null ? null : modifiedBy,
        "modificationDate": modificationDate == null
            ? null
            : modificationDate!.toIso8601String(),
        "creditamountLocal":
            creditAmountLocal == null ? null : creditAmountLocal,
      };
}
