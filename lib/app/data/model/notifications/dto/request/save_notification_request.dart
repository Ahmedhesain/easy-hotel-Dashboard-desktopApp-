class SaveNotificationRequest{
  SaveNotificationRequest({
    this.createdBy,
    this.createdDate,
    this.id,
    this.serial,
    this.date,
    this.organizationSiteId,
    this.organizationSiteName,
    this.remark,
    this.typeNotice,
    this.gallaryId,
    this.generalJournalId,
    this.value,
    this.branchId,
    this.companyId,
    this.invInvoice,
    this.invInvoiceSerial,
  });

  int? gallaryId;
  int? generalJournalId;
  int? createdBy;
  DateTime? createdDate;
  int? id;
  int? serial;
  DateTime? date;
  int? organizationSiteId;
  String? remark;
  String? organizationSiteName;
  int? typeNotice;
  int? invInvoice;
  int? invInvoiceSerial;
  int? branchId;
  int? companyId;
  double? value;

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "generalJournalId": generalJournalId,
    "id": id,
    "gallaryId": gallaryId,
    "invInvoice": invInvoice,
    "organizationSiteName": organizationSiteName,
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