// To parse this JSON data, do
//
//     final khaznaModel = khaznaModelFromJson(jsonString);

import 'dart:convert';

class EditBillsResponse {
  EditBillsResponse({
    this.bank,
    this.bankName,
    this.bankId,
    this.remain,
    this.value,
    this.invoiceId,
    this.invoiceSerial,
    this.id,
    this.customerId,
    this.customerName,
    this.remark,
    this.date,
    this.generalJournalId,
    this.serial
  });

  Bank? bank;
  String? bankName;
  int? bankId;
  num ?remain;
  num? value;
  int ?invoiceId;
  int? invoiceSerial;
  int? serial;

  int? id;
  int? customerId;
  String? customerName;
  String? remark;
  DateTime? date;
  int?generalJournalId;


  static List<EditBillsResponse> fromList(List<dynamic> json) => List.from(json.map((e) => EditBillsResponse.fromJson(e)));

  factory EditBillsResponse.fromJson(Map<String, dynamic> json) => EditBillsResponse(
    bank: json["bank"] == null ? null : Bank.fromJson(json["bank"]),
    bankName: json["bankName"] == null ? null : json["bankName"],
    bankId: json["bankId"],
    remain: json["remain"] == null ? null : json["remain"],
    value: json["value"] == null ? null : json["value"],
    invoiceId: json["invoiceId"] == null ? null : json["invoiceId"],
    invoiceSerial: json["invoiceSerial"] == null ? null : json["invoiceSerial"],
    id: json["id"] == null ? null : json["id"],
    customerId: json["customerId"] == null ? null : json["customerId"],
    customerName: json["customerName"] == null ? null : json["customerName"],
    remark: json["remark"] == null ? null : json["remark"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    generalJournalId: json["generalJournalId"] == null ? null : json["generalJournalId"],
    serial: json["serial"] == null ? null : json["serial"],


  );

  Map<String, dynamic> toJson() => {
    "bank": bank == null ? null : bank!.toJson(),
    "bankName": bankName == null ? null : bankName,
    "remain": remain == null ? null : remain,
    "value": value == null ? null : value,
    "bankId": bankId,
    "invoiceId": invoiceId == null ? null : invoiceId,
    "invoiceSerial": invoiceSerial == null ? null : invoiceSerial,
    "id": id == null ? null : id,
    "customerId": customerId == null ? null : customerId,
    "customerName": customerName == null ? null : customerName,
    "remark": remark == null ? null : remark,
    "date": date == null ? null : date!.toIso8601String(),

    "generalJournalId": generalJournalId == null ? null : generalJournalId,
    "serial": serial == null ? null : serial,


  };
}

class Bank {
  Bank();

  factory Bank.fromRawJson(String str) => Bank.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
  );

  Map<String, dynamic> toJson() => {
  };
}
