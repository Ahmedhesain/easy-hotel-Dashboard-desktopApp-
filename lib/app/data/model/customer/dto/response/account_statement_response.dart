
class AccountStatementResponse {

  AccountStatementResponse({
    required this.adding,
    required this.exitt,
    required this.openningBalance,
    required this.organizationCode,
    required this.organizationName,
    required this.organizationSiteId,
    required this.remarks,
    required this.screenName,
    required this.serial,
    required this.date,
    required this.invoiceSerial,
  });

  final num adding;
  final num exitt;
  final num openningBalance;
  final String organizationCode;
  final String organizationName;
  final num organizationSiteId;
  final String? remarks;
  final String screenName;
  final num serial;
  final DateTime? date;
  final num? invoiceSerial;

  static List<AccountStatementResponse> fromList(List<dynamic> json) => List<AccountStatementResponse>.from(json.map((e) => AccountStatementResponse.fromJson(e)));

  factory AccountStatementResponse.fromJson(Map<String, dynamic> json) => AccountStatementResponse(
    adding: json["adding"].toDouble(),
    exitt: json["exitt"].toDouble(),
    openningBalance: json["openningBalance"],
    organizationCode: json["organizationCode"],
    organizationName: json["organizationName"],
    organizationSiteId: json["organizationSiteId"],
    remarks: json["remarks"],
    screenName: json["screenName"],
    serial: json["serial"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    invoiceSerial: json["invoiceSerial"],
  );

  Map<String, dynamic> toJson() => {
    "adding": adding,
    "exitt": exitt,
    "openningBalance": openningBalance,
    "organizationCode": organizationCode,
    "organizationName": organizationName,
    "organizationSiteId": organizationSiteId,
    "remarks": remarks,
    "screenName": screenName,
    "serial": serial,
    "date": date?.toIso8601String(),
    "invoiceSerial": invoiceSerial,
  };

}