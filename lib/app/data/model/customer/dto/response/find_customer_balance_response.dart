import '../../../common/sales_statement_for_the_period.dart';

class FindCustomerBalanceResponse {
  FindCustomerBalanceResponse({
    required this.balance,
    required this.invoicesList,
  });

  final num balance;
  final List<InvoiceList> invoicesList;

  factory FindCustomerBalanceResponse.fromJson(Map<String, dynamic> json) => FindCustomerBalanceResponse(
    balance: json["balance"],
    invoicesList: List<InvoiceList>.from(json["invoicesList"].map((x) => InvoiceList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "invoicesList": List<dynamic>.from(invoicesList.map((x) => x.toJson())),
  };
}

class InvoiceList {
  InvoiceList({
    required this.id,
    required this.serial,
    required this.date,
    required this.net,
    required this.remarks,
    required this.salesStatementForThePeriod,
  });

  final int id;
  final int? serial;
  final DateTime date;
  final num net;
  final String remarks;
  final SalesStatementForThePeriod salesStatementForThePeriod;

  factory InvoiceList.fromJson(Map<String, dynamic> json) => InvoiceList(
    id: json["id"],
    serial: json["serial"],
    date: DateTime.parse(json["date"]),
    net: json["net"],
    remarks: json["remarks"],
    salesStatementForThePeriod: SalesStatementForThePeriod.fromJson(json["salesStatementForThePeriod"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serial": serial,
    "date": date.toIso8601String(),
    "net": net,
    "remarks": remarks,
    "salesStatementForThePeriod": salesStatementForThePeriod.toJson(),
  };
}

