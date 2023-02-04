

class SalesStatementForThePeriod {
  SalesStatementForThePeriod({
    required this.cash,
    required this.gallaryListSelected,
    required this.invNoticeValue,
    required this.invoiceId,
    required this.net,
    required this.noticeCredit,
    required this.noticeDebit,
    required this.paid,
    required this.remain,
    required this.returnPurchaseValue,
    required this.serial,
    required this.tax,
    required this.totalAfterDiscount,
    required this.totalAfterTax,
    required this.totalBeforeTax,
    required this.totalNet,
  });

  final num cash;
  final List<dynamic> gallaryListSelected;
  final num invNoticeValue;
  final num invoiceId;
  final num net;
  final num noticeCredit;
  final num noticeDebit;
  final num paid;
  num remain;
  final num returnPurchaseValue;
  final int serial;
  final num tax;
  final num totalAfterDiscount;
  final num totalAfterTax;
  final num totalBeforeTax;
  final num totalNet;

  factory SalesStatementForThePeriod.fromJson(Map<String, dynamic> json) => SalesStatementForThePeriod(
    cash: json["cash"],
    gallaryListSelected: List<dynamic>.from(json["gallaryListSelected"].map((x) => x)),
    invNoticeValue: json["invNoticeValue"],
    invoiceId: json["invoiceId"],
    net: json["net"],
    noticeCredit: json["noticeCredit"],
    noticeDebit: json["noticeDebit"],
    paid: json["paid"],
    remain: json["remain"],
    returnPurchaseValue: json["returnPurchaseValue"],
    serial: json["serial"],
    tax: json["tax"],
    totalAfterDiscount: json["totalAfterDiscount"],
    totalAfterTax: json["totalAfterTax"],
    totalBeforeTax: json["totalBeforeTax"],
    totalNet: json["totalNet"],
  );

  Map<String, dynamic> toJson() => {
    "cash": cash,
    "gallaryListSelected": List<dynamic>.from(gallaryListSelected.map((x) => x)),
    "invNoticeValue": invNoticeValue,
    "invoiceId": invoiceId,
    "net": net,
    "noticeCredit": noticeCredit,
    "noticeDebit": noticeDebit,
    "paid": paid,
    "remain": remain,
    "returnPurchaseValue": returnPurchaseValue,
    "serial": serial,
    "tax": tax,
    "totalAfterDiscount": totalAfterDiscount,
    "totalAfterTax": totalAfterTax,
    "totalBeforeTax": totalBeforeTax,
    "totalNet": totalNet,
  };
}