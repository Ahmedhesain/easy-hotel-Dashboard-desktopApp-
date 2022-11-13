// To parse this JSON data, do
//
//     final categoriesItemsResponse = categoriesItemsResponseFromJson(jsonString);

import 'dart:convert';

class CategoriesItemsResponse {
  CategoriesItemsResponse({
    this.cash,
    this.code,
    this.gallaryListSelected,
    this.galleryName,
    this.invNoticeValue,
    this.invoiceDate,
    this.invoiceId,
    this.invoiceStatus,
    this.name,
    this.net,
    this.notZeroValue,
    this.noticeCredit,
    this.noticeDebit,
    this.paid,
    this.remain,
    this.remainBoolean,
    this.remainValue,
    this.returnPurchaseValue,
    this.serial,
    this.tax,
    this.totalAfterDiscount,
    this.totalAfterTax,
    this.totalBeforeTax,
    this.totalNet,
    this.zeroValue,
  });

  num ?cash;
  String? code;
  List<dynamic>? gallaryListSelected;
  String ?galleryName;
  num ?invNoticeValue;
  DateTime? invoiceDate;
  int ?invoiceId;
  String? invoiceStatus;
  String ?name;
  num ?net;
  bool? notZeroValue;
  num ?noticeCredit;
  num? noticeDebit;
  num?paid;
  num? remain;
  bool? remainBoolean;
  num?remainValue;
  num?returnPurchaseValue;
  int ?serial;
  num? tax;
  num?totalAfterDiscount;
  num?totalAfterTax;
  num?totalBeforeTax;
  num?totalNet;
  bool? zeroValue;

  static List<CategoriesItemsResponse> fromList(List<dynamic> json) => List.from(json.map((e) => CategoriesItemsResponse.fromJson(e)));


  factory CategoriesItemsResponse.fromRawJson(String str) => CategoriesItemsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriesItemsResponse.fromJson(Map<String, dynamic> json) => CategoriesItemsResponse(
    cash: json["cash"] == null ? null : json["cash"],
    code: json["code"] == null ? null : json["code"],
    gallaryListSelected: json["gallaryListSelected"] == null ? null : List<dynamic>.from(json["gallaryListSelected"].map((x) => x)),
    galleryName: json["galleryName"] == null ? null : json["galleryName"],
    invNoticeValue: json["invNoticeValue"] == null ? null : json["invNoticeValue"],
    invoiceDate: json["invoiceDate"] == null ? null : DateTime.parse(json["invoiceDate"]),
    invoiceId: json["invoiceId"] == null ? null : json["invoiceId"],
    invoiceStatus: json["invoiceStatus"] == null ? null : json["invoiceStatus"],
    name: json["name"] == null ? null : json["name"],
    net: json["net"] == null ? null : json["net"],
    notZeroValue: json["notZeroValue"] == null ? null : json["notZeroValue"],
    noticeCredit: json["noticeCredit"] == null ? null : json["noticeCredit"],
    noticeDebit: json["noticeDebit"] == null ? null : json["noticeDebit"],
    paid: json["paid"] == null ? null : json["paid"],
    remain: json["remain"] == null ? null : json["remain"],
    remainBoolean: json["remainBoolean"] == null ? null : json["remainBoolean"],
    remainValue: json["remainValue"] == null ? null : json["remainValue"],
    returnPurchaseValue: json["returnPurchaseValue"] == null ? null : json["returnPurchaseValue"],
    serial: json["serial"] == null ? null : json["serial"],
    tax: json["tax"] == null ? null : json["tax"],
    totalAfterDiscount: json["totalAfterDiscount"] == null ? null : json["totalAfterDiscount"],
    totalAfterTax: json["totalAfterTax"] == null ? null : json["totalAfterTax"],
    totalBeforeTax: json["totalBeforeTax"] == null ? null : json["totalBeforeTax"],
    totalNet: json["totalNet"] == null ? null : json["totalNet"],
    zeroValue: json["zeroValue"] == null ? null : json["zeroValue"],
  );

  Map<String, dynamic> toJson() => {
    "cash": cash == null ? null : cash,
    "code": code == null ? null : code,
    "gallaryListSelected": gallaryListSelected == null ? null : List<dynamic>.from(gallaryListSelected!.map((x) => x)),
    "galleryName": galleryName == null ? null : galleryName,
    "invNoticeValue": invNoticeValue == null ? null : invNoticeValue,
    "invoiceDate": invoiceDate == null ? null : invoiceDate?.toIso8601String(),
    "invoiceId": invoiceId == null ? null : invoiceId,
    "invoiceStatus": invoiceStatus == null ? null : invoiceStatus,
    "name": name == null ? null : name,
    "net": net == null ? null : net,
    "notZeroValue": notZeroValue == null ? null : notZeroValue,
    "noticeCredit": noticeCredit == null ? null : noticeCredit,
    "noticeDebit": noticeDebit == null ? null : noticeDebit,
    "paid": paid == null ? null : paid,
    "remain": remain == null ? null : remain,
    "remainBoolean": remainBoolean == null ? null : remainBoolean,
    "remainValue": remainValue == null ? null : remainValue,
    "returnPurchaseValue": returnPurchaseValue == null ? null : returnPurchaseValue,
    "serial": serial == null ? null : serial,
    "tax": tax == null ? null : tax,
    "totalAfterDiscount": totalAfterDiscount == null ? null : totalAfterDiscount,
    "totalAfterTax": totalAfterTax == null ? null : totalAfterTax,
    "totalBeforeTax": totalBeforeTax == null ? null : totalBeforeTax,
    "totalNet": totalNet == null ? null : totalNet,
    "zeroValue": zeroValue == null ? null : zeroValue,
  };
}
