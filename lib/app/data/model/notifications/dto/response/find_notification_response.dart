class FindNotificationResponse {
  FindNotificationResponse({
    this.type,
    this.createdBy,
    this.createdDate,
    this.id,
    this.index,
    this.serial,
    this.date,
    this.generalJournalId,
    this.invInvoice,
    this.invInvoiceSerial,
    this.organizationSiteCode,
    this.organizationSiteId,
    this.organizationSiteName,
    this.remark,
    this.typeName,
    this.typeNotice,
    this.gallaryId,
    this.value,
  });

  String? type;
  int? gallaryId;
  int? createdBy;
  DateTime? createdDate;
  int? id;
  int? index;
  int? serial;
  DateTime? date;
  int? generalJournalId;
  int? invInvoice;
  int? invInvoiceSerial;
  String? organizationSiteCode;
  int? organizationSiteId;
  String? organizationSiteName;
  String? remark;
  String? typeName;
  int? typeNotice;
  double? value;

  static List<FindNotificationResponse> fromList(List<dynamic> json) => List<FindNotificationResponse>.from(json.map((e)=>FindNotificationResponse.fromJson(e)));

  factory FindNotificationResponse.fromJson(Map<String, dynamic> json) => FindNotificationResponse(
    type: json["type"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    id: json["id"],
    index: json["index"],
    serial: json["serial"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    generalJournalId: json["generalJournalId"],
    invInvoice: json["invInvoice"],
    invInvoiceSerial: json["invInvoiceSerial"],
    organizationSiteCode: json["organizationSiteCode"],
    organizationSiteId: json["organizationSiteId"],
    organizationSiteName: json["organizationSiteName"],
    remark: json["remark"],
    typeName: json["typeName"],
    typeNotice: json["typeNotice"],
    gallaryId: json["gallaryId"],
    value: json["value"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "id": id,
    "gallaryId": gallaryId,
    "index": index,
    "serial": serial,
    "date": date?.toIso8601String(),
    "generalJournalId": generalJournalId,
    "invInvoice": invInvoice,
    "invInvoiceSerial": invInvoiceSerial,
    "organizationSiteCode": organizationSiteCode,
    "organizationSiteId": organizationSiteId,
    "organizationSiteName": organizationSiteName,
    "remark": remark,
    "typeName": typeName,
    "typeNotice": typeNotice,
    "value": value,
  };

  @override
  String toString() {
    return serial.toString();
  }
}
