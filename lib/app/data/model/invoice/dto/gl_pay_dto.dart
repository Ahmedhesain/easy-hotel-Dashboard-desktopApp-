import 'dart:convert';
import 'package:toby_bills/app/core/mixins/form_mixin.dart';

class GlPayDTO with FormMixin{
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
    this.gallaryId,
    this.generalJournalId,
    this.serial
  }){
    textFieldController1.text = customerName??"";
    textFieldController2.text = invoiceSerial?.toString()??"";
    textFieldController3.text = value?.toStringAsFixed(2)??"";
    textFieldController4.text = bankName??"";
    textFieldController5.text = remark??"";
  }

  Bank? bank;
  String? bankName;
  int? bankId;
  num ?remain;
  num? value;
  int ?invoiceId;
  int? invoiceSerial;
  int? gallaryId;
  int? generalJournalId;
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
    gallaryId: json["gallaryId"],
    generalJournalId: json["generalJournalId"],
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
    "generalJournalId": generalJournalId,
    "gallaryId": gallaryId,

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
