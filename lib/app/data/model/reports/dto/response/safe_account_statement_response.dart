import 'dart:convert';

List<BankStatement> bankStatementsFromJson(String str) => List<BankStatement>.from(json.decode(str).map((x) => BankStatement.fromJson(x)));

class TreasuryModel{

  TreasuryModel({required this.bankName, required this.statements});
  final String? bankName;
  final List<BankStatement> statements;

}

class BankStatement {
  BankStatement({
    required this.balance,
    required this.bankId,
    required this.bankName,
    required this.code,
    required this.createdBy,
    required this.currencyCode,
    required this.currencyName,
    required this.customerCode,
    required this.customerName,
    required this.date,
    required this.debitAmount,
    required this.invoiceNumber,
    required this.openingBalance,
    required this.remark,
    required this.remark2,
    required this.serial,
    required this.totalCredit,
    required this.totalDebit,
    required this.transactionType,
  });

  final num? balance;
  final int? bankId;
  final String? bankName;
  final int? code;
  final String? createdBy;
  final String? currencyCode;
  final String? currencyName;
  final String? customerCode;
  final String? customerName;
  final DateTime? date;
  final num? debitAmount;
  final int? invoiceNumber;
  final num? openingBalance;
  final String? remark;
  final String? remark2;
  final String? serial;
  final num? totalCredit;
  final num? totalDebit;
  final String? transactionType;


  static List<BankStatement> fromList(List<dynamic> json) => List.from(json.map((e) => BankStatement.fromJson(e)));

  factory BankStatement.fromJson(Map<String, dynamic> json) => BankStatement(
    balance: json["balance"],
    bankId: json["bankId"],
    bankName: json["bankName"],
    code: json["code"],
    createdBy: json["createdBy"],
    currencyCode: json["currencyCode"],
    currencyName: json["currencyName"],
    customerCode: json["customerCode"],
    customerName: json["customerName"],
    date: json["date"] == null?null:DateTime.parse(json["date"]),
    debitAmount: json["debitAmount"],
    invoiceNumber: json["invoiceNumber"],
    openingBalance: json["openingBalance"],
    remark: json["remark"],
    remark2: json["remark2"],
    serial: json["serial"],
    totalCredit: json["totalCredit"],
    totalDebit: json["totalDebit"],
    transactionType: json["transactionType"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "bankId": bankId,
    "bankName": bankName,
    "code": code,
    "createdBy": createdBy,
    "currencyCode": currencyCode,
    "currencyName": currencyName,
    "customerCode": customerCode,
    "customerName": customerName,
    "date": date?.toIso8601String(),
    "debitAmount": debitAmount,
    "invoiceNumber": invoiceNumber,
    "openingBalance": openingBalance,
    "remark": remark,
    "remark2": remark2,
    "serial": serial,
    "totalCredit": totalCredit,
    "totalDebit": totalDebit,
    "transactionType": transactionType,
  };
}
