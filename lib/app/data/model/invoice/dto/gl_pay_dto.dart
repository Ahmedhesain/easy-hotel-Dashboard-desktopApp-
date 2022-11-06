// To parse this JSON data, do
//
//     final khaznaModel = khaznaModelFromJson(jsonString);

import 'dart:convert';

class GlPayDTO {
  GlPayDTO({
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
    this.serial
  });

  Bank? bank;
  String? bankName;
  int? bankId;
  num ?remain;
  num? value;
  int ?invoiceId;
  int? invoiceSerial;
  int? id;
  int? customerId;
  String? customerName;
  String? remark;
  DateTime? date;
  int?serial;


  static List<GlPayDTO> fromList(List<dynamic> json) => List.from(json.map((e) => GlPayDTO.fromJson(e)));

  factory GlPayDTO.fromJson(Map<String, dynamic> json) => GlPayDTO(
    bank: json["bank"] == null ? null : Bank.fromJson(json["bank"]),
    bankName: json["bankName"],
    bankId: json["bankId"],
    remain: json["remain"],
    value: json["value"],
    invoiceId: json["invoiceId"],
    invoiceSerial: json["invoiceSerial"],
    id: json["id"],
    customerId: json["customerId"],
    customerName: json["customerName"],
    remark: json["remark"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    serial: json["serial"],

  );

  Map<String, dynamic> toJson() => {
    "bank": bank == null ? null : bank!.toJson(),
    "bankName": bankName,
    "remain": remain,
    "value": value,
    "bankId": bankId,
    "invoiceId": invoiceId,
    "invoiceSerial": invoiceSerial,
    "id": id,
    "customerId": customerId,
    "customerName": customerName,
    "remark": remark,
    "date": date == null ? null : date!.toIso8601String(),
    "serial": serial,

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
