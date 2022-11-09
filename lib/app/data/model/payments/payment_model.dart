import 'package:toby_bills/app/core/mixins/form_mixin.dart';

class PaymentModel {
  PaymentModel({
    this.type,
    this.branchId,
    this.companyId,
    this.createdBy,
    this.createdDate,
    this.id,
    this.date,
    this.generalJournalId,
    this.glBankTransactionDetailFromApiList,
    this.isDebit,
    this.remark,
    this.totalValue,
    this.glAccountId,
    this.costCenterId,
    this.serial,
  });

  String? type;
  int? branchId;
  int? companyId;
  int? createdBy;
  DateTime? createdDate;
  int? id;
  int? serial;
  int? glAccountId;
  int? costCenterId;
  DateTime? date;
  int? generalJournalId;
  List<GlBankTransactionDetail>? glBankTransactionDetailFromApiList = [];
  bool? isDebit;
  String? remark;
  num? totalValue;

  PaymentModel copyWith({
    String? type,
    int? branchId,
    int? companyId,
    int? createdBy,
    DateTime? createdDate,
    int? id,
    int? serial,
    int? glAccountId,
    int? costCenterId,
    DateTime? date,
    int? generalJournalId,
    List<GlBankTransactionDetail>? glBankTransactionDetailFromApiList,
    bool? isDebit,
    String? remark,
    num? totalValue,
  }) => PaymentModel(
    serial: serial ?? this.serial,
    type: type ?? this.type,
    branchId: branchId ?? this.branchId,
    companyId: companyId ?? this.companyId,
    createdBy: createdBy ?? this.createdBy,
    createdDate: createdDate ?? this.createdDate,
    id: id ?? this.id,
    date: date ?? this.date,
    generalJournalId: generalJournalId ?? this.generalJournalId,
    glBankTransactionDetailFromApiList: glBankTransactionDetailFromApiList ?? this.glBankTransactionDetailFromApiList,
    isDebit: isDebit ?? this.isDebit,
    remark: remark ?? this.remark,
    totalValue: totalValue ?? this.totalValue,
    costCenterId: costCenterId ?? this.costCenterId,
    glAccountId: glAccountId ?? this.glAccountId,
  );

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    serial: json["serial"],
    type: json["type"],
    branchId: json["branchId"],
    companyId: json["companyId"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"] == null?null:DateTime.parse(json["createdDate"]),
    id: json["id"],
    date: json["date"] == null?null:DateTime.parse(json["date"]),
    generalJournalId: json["generalJournalId"],
    glBankTransactionDetailFromApiList: List<GlBankTransactionDetail>.from((json["glBankTransactionDetailFromAPIList"]??[]).map((x) => GlBankTransactionDetail.fromJson(x))),
    isDebit: json["isDebit"],
    remark: json["remark"],
    totalValue: json["totalValue"],
    costCenterId: json["costCenterId"],
    glAccountId: json["glAccountId"],
  );

  Map<String, dynamic> toJson() => {
    "costCenterId": costCenterId,
    "serial": serial,
    "glAccountId": glAccountId,
    "type": type,
    "branchId": branchId,
    "companyId": companyId,
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "id": id,
    "date": date?.toIso8601String(),
    "generalJournalId": generalJournalId,
    "glBankTransactionDetailFromAPIList": List<dynamic>.from((glBankTransactionDetailFromApiList??[]).map((x) => x.toJson())),
    "isDebit": isDebit,
    "remark": remark,
    "totalValue": totalValue,
  };
}

class GlBankTransactionDetail with FormMixin{
  GlBankTransactionDetail({
    this.companyId,
    this.createdBy,
    this.createdDate,
    this.id,
    this.serial,
    this.bankCommition,
    this.glAccountCreditCode,
    this.glAccountCreditId,
    this.glAccountCreditName,
    this.glAccountDebitCode,
    this.glAccountDebitId,
    this.glAccountDebitName,
    this.glBankTransactionId,
    this.invOrganizationSiteCode,
    this.invOrganizationSiteId,
    this.invOrganizationSiteName,
    this.remarks,
    this.value,
    this.invoiceId,
    this.invoiceSerial,
    this.valueLocal,
    this.costCenterCode,
    this.costCenterId,
    this.costCenterName,
  }){
    textFieldController1.text = "$invOrganizationSiteName $invOrganizationSiteCode";
    textFieldController2.text = "$invoiceSerial";
    textFieldController3.text = "$glAccountDebitName $glAccountDebitCode";
    textFieldController4.text = "$glAccountCreditName $glAccountCreditCode";
    textFieldController5.text = "$value";
    textFieldController6.text = bankCommition?.toString()??"";
    textFieldController7.text = "$costCenterName";
    textFieldController8.text = "$remarks";
  }

  int? companyId;
  int? createdBy;
  int? invoiceId;
  int? invoiceSerial;
  int? costCenterId;
  int? costCenterCode;
  String? costCenterName;
  DateTime? createdDate;
  int? id;
  int? serial;
  num? bankCommition;
  int? glAccountCreditCode;
  int? glAccountCreditId;
  String? glAccountCreditName;
  int? glAccountDebitCode;
  int? glAccountDebitId;
  String? glAccountDebitName;
  int? glBankTransactionId;
  String? invOrganizationSiteCode;
  int? invOrganizationSiteId;
  String? invOrganizationSiteName;
  String? remarks;
  num? value;
  num? valueLocal;

  factory GlBankTransactionDetail.fromJson(Map<String, dynamic> json) => GlBankTransactionDetail(
    companyId: json["companyId"],
    invoiceId: json["invoiceId"],
    invoiceSerial: json["invoiceSerial"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    id: json["id"],
    serial: json["serial"],
    bankCommition: json["bankCommition"],
    glAccountCreditCode: json["glAccountCreditCode"],
    glAccountCreditId: json["glAccountCreditId"],
    glAccountCreditName: json["glAccountCreditName"],
    glAccountDebitCode: json["glAccountDebitCode"],
    glAccountDebitId: json["glAccountDebitId"],
    glAccountDebitName: json["glAccountDebitName"],
    glBankTransactionId: json["glBankTransactionId"],
    invOrganizationSiteCode: json["invOrganizationSiteCode"],
    invOrganizationSiteId: json["invOrganizationSiteId"],
    invOrganizationSiteName: json["invOrganizationSiteName"],
    remarks: json["remarks"],
    value: json["value"],
    valueLocal: json["valueLocal"],
    costCenterId: json["costCenterId"],
    costCenterName: json["costCenterName"],
    costCenterCode: json["costCenterCode"],
  );

  GlBankTransactionDetail copyWith({
    int? companyId,
    int? createdBy,
    DateTime? createdDate,
    int? id,
    int? serial,
    num? bankCommition,
    int? glAccountCreditCode,
    int? glAccountCreditId,
    String? glAccountCreditName,
    int? glAccountDebitCode,
    int? glAccountDebitId,
    String? glAccountDebitName,
    int? glBankTransactionId,
    String? invOrganizationSiteCode,
    int? invOrganizationSiteId,
    String? invOrganizationSiteName,
    String? remarks,
    num? value,
    int? invoiceId,
    int? invoiceSerial,
    num? valueLocal,
    int? costCenterCode,
    int? costCenterId,
    String? costCenterName,
  }) => GlBankTransactionDetail(
    companyId: companyId ?? this.companyId,
    invoiceId: invoiceId ?? this.invoiceId,
    invoiceSerial: invoiceSerial ?? this.invoiceSerial,
    createdBy: createdBy ?? this.createdBy,
    createdDate: createdDate ?? this.createdDate,
    id: id ?? this.id,
    serial: serial ?? this.serial,
    bankCommition: bankCommition ?? this.bankCommition,
    glAccountCreditCode: glAccountCreditCode ?? this.glAccountCreditCode,
    glAccountCreditId: glAccountCreditId ?? this.glAccountCreditId,
    glAccountCreditName: glAccountCreditName ?? this.glAccountCreditName,
    glAccountDebitCode: glAccountDebitCode ?? this.glAccountDebitCode,
    glAccountDebitId: glAccountDebitId ?? this.glAccountDebitId,
    glAccountDebitName: glAccountDebitName ?? this.glAccountDebitName,
    glBankTransactionId: glBankTransactionId ?? this.glBankTransactionId,
    invOrganizationSiteCode: invOrganizationSiteCode ?? this.invOrganizationSiteCode,
    invOrganizationSiteId: invOrganizationSiteId ?? this.invOrganizationSiteId,
    invOrganizationSiteName: invOrganizationSiteName ?? this.invOrganizationSiteName,
    remarks: remarks ?? this.remarks,
    value: value ?? this.value,
    valueLocal: valueLocal ?? this.valueLocal,
    costCenterId: costCenterId ?? this.costCenterId,
    costCenterName: costCenterName ?? this.costCenterName,
    costCenterCode: costCenterCode ?? this.costCenterCode,
  );

  Map<String, dynamic> toJson() => {
    "companyId": companyId,
    "invoiceSerial": invoiceSerial,
    "costCenterId": costCenterId,
    "costCenterName": costCenterName,
    "costCenterCode": costCenterCode,
    "invoiceId": invoiceId,
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "id": id,
    "serial": serial,
    "bankCommition": bankCommition,
    "glAccountCreditCode": glAccountCreditCode,
    "glAccountCreditId": glAccountCreditId,
    "glAccountCreditName": glAccountCreditName,
    "glAccountDebitCode": glAccountDebitCode,
    "glAccountDebitId": glAccountDebitId,
    "glAccountDebitName": glAccountDebitName,
    "glBankTransactionId": glBankTransactionId,
    "invOrganizationSiteCode": invOrganizationSiteCode,
    "invOrganizationSiteId": invOrganizationSiteId,
    "invOrganizationSiteName": invOrganizationSiteName,
    "remarks": remarks,
    "value": value,
    "valueLocal": valueLocal,
  };
}
