class SaveNotificationRequest{
  SaveNotificationRequest({
    this.createdBy,
    this.createdDate,
    this.id,
    this.serial,
    this.date,
    this.organizationSiteId,
    this.remark,
    this.typeNotice,
    this.gallaryId,
    this.value,
    this.branchId,
    this.companyId,
    this.invInvoice,
    this.invInvoiceSerial,
  });

  int? gallaryId;
  int? createdBy;
  DateTime? createdDate;
  int? id;
  int? serial;
  DateTime? date;
  int? organizationSiteId;
  String? remark;
  int? typeNotice;
  int? invInvoice;
  int? invInvoiceSerial;
  int? branchId;
  int? companyId;
  double? value;

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "id": id,
    "gallaryId": gallaryId,
    "invInvoice": invInvoice,
    "invInvoiceSerial": invInvoiceSerial,
    "serial": serial,
    "date": date?.toIso8601String(),
    "organizationSiteId": organizationSiteId,
    "remark": remark,
    "typeNotice": typeNotice,
    "value": value,
    "branchId": branchId,
    "companyId": companyId,
  };
}