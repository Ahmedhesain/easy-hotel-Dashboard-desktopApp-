
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/invoice/invoice_detail_model.dart';

class InvoiceStatementByCaseResponse {

  InvoiceStatementByCaseResponse({
    this.type,
    this.companyId,
    this.branchId,
    this.createdBy,
    this.createdByName,
    this.createdDate,
    this.id,
    this.index,
    this.markEdit,
    this.serial,
    this.customerBalance,
    this.customerCode,
    this.customerEmail,
    this.customerId,
    this.customerMobile,
    this.customerName,
    this.customerNotice,
    this.date,
    this.discHalala,
    this.discount,
    this.discountType,
    this.gallaryDeliveryId,
    this.gallaryDeliveryName,
    this.dueDate,
    this.dueperiod,
    this.gallaryId,
    this.gallaryName,
    this.invDelegatorId,
    this.invDelegatorName,
    this.invInventoryId,
    this.invInventoryName,
    this.invoiceDate,
    this.invoiceDetailApiList,
    this.invoiceDetailApiListDeleted,
    this.invoiceNumber,
    this.length,
    this.offerCopoun,
    this.pricetype,
    this.proof,
    this.remarks,
    this.serialTax,
    this.shoulder,
    this.status,
    this.step,
    this.glPayDTOList,
    this.invoiceType,
    this.totalNetAfterDiscount,
    this.finalNet,
    this.taxvalue,
    this.qrCode,
    this.daribaValue,
    this.segilValue,
    this.payed,
    this.invoiceStatus,
    this.salesStatementForThePeriod,
    this.remain,
    this.noticeCredit,
    this.noticeDebit,
    this.returnPurchaseValue,
    this.supplierDate,
    this.invPurchaseInvoice,
    this.proFactoryDeliveryId,
    this.loadedSerial,
    this.numberOfToob,
    this.gallaryPhone,
    this.totalNet,
    this.remainDueDayesNumber,
    this.organizationSiteName,
    this.invoiceLastStatus,
    this.gallaryDeliveryShow
  });

  num? numberOfToob;
  num? loadedSerial;
  String? gallaryPhone;
  DateTime? supplierDate;
  int? invPurchaseInvoice;
  String? invoiceStatus;
  String? type;
  int ?companyId;
  int ?branchId;
  int ?createdBy;
  String? createdByName;
  DateTime? createdDate;
  int ?id;
  int ?index;
  bool? markEdit;
  int ?serial;
  num? customerBalance;
  String? customerCode;
  String? organizationSiteName;
  String? customerEmail;
  String? qrCode;
  int? invoiceType;
  int ?customerId;
  String? customerMobile;
  String? customerName;
  String? customerNotice;
  int? gallaryDeliveryId;
  String? gallaryDeliveryName;
  DateTime? date;
  num ?discHalala;
  num ?discount;
  num ?discountType;
  DateTime? dueDate;
  int? dueperiod;
  int? remainDueDayesNumber;
  int ?gallaryId;
  String? gallaryName;
  int ?invDelegatorId;
  String? invDelegatorName;
  int ?invInventoryId;
  String? invInventoryName;
  DateTime? invoiceDate;
  List<InvoiceDetailsModel>? invoiceDetailApiList;
  List<InvoiceDetailsModel>? invoiceDetailApiListDeleted;
  List<GlPayDTO>? glPayDTOList;
  String ?invoiceNumber;
  num ?length;
  String? offerCopoun;
  int? pricetype;
  int ?proof;
  String? remarks;
  num ?serialTax;
  num? shoulder;
  String? status;
  String? invoiceLastStatus;
  num ?step;
  num ?totalNetAfterDiscount;
  num ?finalNet;
  num ?taxvalue;
  num ?payed;
  String ?daribaValue;
  String ?segilValue;
  BalanceInfoDetailModel? salesStatementForThePeriod;
  num? remain;
  num? noticeCredit;
  num? noticeDebit;
  num? returnPurchaseValue;
  num? totalNet;
  int? proFactoryDeliveryId;
  int?gallaryDeliveryShow;

  static List<InvoiceStatementByCaseResponse> fromList(List<dynamic> json) => List<InvoiceStatementByCaseResponse>.from(json.map((e) => InvoiceStatementByCaseResponse.fromJson(e)));

  factory InvoiceStatementByCaseResponse.fromJson(Map<String, dynamic> json) => InvoiceStatementByCaseResponse(
    type: json["type"],
    companyId: json["companyId"],
    remainDueDayesNumber: json["remainDueDayesNumber"],
    customerNotice: json["customerNotice"],
    createdBy: json["createdBy"],
    invoiceLastStatus: json["invoiceLastStatus"],
    createdByName: json["createdByName"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    id: json["id"],
    index: json["index"],
    markEdit: json["markEdit"],
    serial: json["serial"],
    customerBalance: json["customerBalance"],
    customerCode: json["customerCode"],
    customerEmail: json["customerEmail"],
    customerId: json["customerId"],
    customerMobile: json["customerMobile"],
    customerName: json["customerName"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    invoiceStatus: json["invoiceStatus"],
    discHalala: json["discHalala"],
    discount: json["discount"],
    discountType: json["discountType"],
    dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
    dueperiod: json["dueperiod"],
    gallaryId: json["gallaryId"],
    gallaryName: json["gallaryName"],
    invDelegatorId: json["invDelegatorId"],
    invDelegatorName: json["invDelegatorName"],
    invInventoryId: json["invInventoryId"],
    invInventoryName: json["invInventoryName"],
    invoiceDate: json["invoiceDate"] == null ? null : DateTime.parse(json["invoiceDate"]),
    invoiceDetailApiList: json["invoiceDetailApiList"] == null ? null : List<InvoiceDetailsModel>.from(json["invoiceDetailApiList"].map((x) => InvoiceDetailsModel.fromJson(x))),
    invoiceDetailApiListDeleted: json["invoiceDetailApiListDeleted"] == null ? null : List<InvoiceDetailsModel>.from(json["invoiceDetailApiListDeleted"].map((x) => InvoiceDetailsModel.fromJson(x))),
    glPayDTOList: json["khaznaList"] == null ? null : List<GlPayDTO>.from(json["khaznaList"].map((x) => GlPayDTO.fromJson(x))),
    invoiceNumber: json["invoiceNumber"],
    length: json["length"],
    offerCopoun: json["offerCopoun"],
    pricetype: json["pricetype"],
    proof: json["proof"],
    remarks: json["remarks"],
    serialTax: json["serialTax"],
    shoulder: json["shoulder"],
    status: json["status"],
    step: json["step"],
    qrCode: json["qrCode"],
    gallaryDeliveryName: json["gallaryDeliveryName"],
    salesStatementForThePeriod: json["salesStatementForThePeriod"] == null ? null : BalanceInfoDetailModel.fromJson(json["salesStatementForThePeriod"]),
    gallaryDeliveryId: json["gallaryDeliveryId"],
    daribaValue: json["daribaValue"],
    segilValue: json["segilValue"],
    payed: json["payed"],
    taxvalue: json["taxvalue"],
    totalNetAfterDiscount: json["totalNetAfterDiscount"],
    finalNet: json["finalNet"],
    totalNet: json["totalNet"],
    remain: json["remain"],
    noticeDebit: json["noticeDebit"],
    noticeCredit: json["noticeCredit"],
    returnPurchaseValue: json["returnPurchaseValue"],
    supplierDate: DateTime.tryParse(json["supplierDate"]??""),
    invPurchaseInvoice: json["invPurchaseInvoice"],
    proFactoryDeliveryId: json["proFactoryDeliveryId"],
    loadedSerial: json["loadedSerial"],
    numberOfToob: json["numberOfToob"],
    gallaryPhone: json["gallaryPhone"],
    organizationSiteName: json["organizationSiteName"],
    gallaryDeliveryShow: json["gallaryDeliveryShow"],
  );


  Map<String, dynamic> toJson() => {
    "proFactoryDeliveryId": proFactoryDeliveryId,
    "invoiceLastStatus": invoiceLastStatus,
    "customerNotice": customerNotice,
    "gallaryPhone": gallaryPhone,
    "remainDueDayesNumber": remainDueDayesNumber,
    "organizationSiteName": organizationSiteName,
    "loadedSerial": loadedSerial,
    "numberOfToob": numberOfToob,
    "supplierDate": supplierDate?.toIso8601String(),
    "invPurchaseInvoice": invPurchaseInvoice,
    "noticeDebit": noticeDebit,
    "noticeCredit": noticeCredit,
    "remain": remain,
    "totalNet": totalNet,
    "returnPurchaseValue": returnPurchaseValue,
    "type": type,
    "companyId": companyId,
    "createdBy": createdBy,
    "createdByName": createdByName,
    "createdDate": createdDate == null ? null : createdDate!.toIso8601String(),
    "id": id,
    "index": index,
    "markEdit": markEdit,
    "serial": serial,
    "customerBalance": customerBalance,
    "customerCode": customerCode,
    "customerEmail": customerEmail,
    "customerId": customerId,
    "customerMobile": customerMobile,
    "customerName": customerName,
    "date": date == null ? null : date!.toIso8601String(),
    "discHalala": discHalala,
    "discount": discount,
    "discountType": discountType,
    "dueDate": dueDate == null ? null : dueDate!.toIso8601String(),
    "dueperiod": dueperiod,
    "gallaryId": gallaryId,
    "gallaryName": gallaryName,
    "invDelegatorId": invDelegatorId,
    "invDelegatorName": invDelegatorName,
    "invInventoryId": invInventoryId,
    "invInventoryName": invInventoryName,
    "invoiceDate": invoiceDate == null ? null : invoiceDate!.toIso8601String(),
    "invoiceDetailApiList": invoiceDetailApiList == null ? null : List<dynamic>.from(invoiceDetailApiList!.map((x) => x)),
    "invoiceDetailApiListDeleted": invoiceDetailApiListDeleted == null ? null : List<dynamic>.from(invoiceDetailApiListDeleted!.map((x) => x)),
    "glPayDTOList": glPayDTOList == null ? null : List<dynamic>.from(glPayDTOList!.map((x) => x.toJson())),
    "invoiceNumber": invoiceNumber,
    "length": length,
    "offerCopoun": offerCopoun,
    "pricetype": pricetype,
    "proof": proof,
    "remarks": remarks,
    "serialTax": serialTax,
    "shoulder": shoulder,
    "status": status,
    "step": step,
    "gallaryDeliveryId": gallaryDeliveryId,
    "gallaryDeliveryName": gallaryDeliveryName,
    "invoiceType": invoiceType,
    "totalNetAfterDiscount": totalNetAfterDiscount,
    "finalNet": finalNet,
    "taxvalue": taxvalue,
    "payed": payed,
    "branchId": branchId,
    "salesStatementForThePeriod": salesStatementForThePeriod == null ? null : salesStatementForThePeriod!.toJson(),
    "gallaryDeliveryShow":gallaryDeliveryShow,
  };

}


class BalanceInfoDetailModel {

  BalanceInfoDetailModel({
    this.cash,
    this.gallaryListSelected,
    this.invNoticeValue,
    this.invoiceId,
    this.net,
    this.noticeCredit,
    this.noticeDebit,
    this.paid,
    this.remain,
    this.returnPurchaseValue,
    this.serial,
    this.tax,
    this.totalAfterTax,
    this.totalBeforeTax,
    this.totalNet,
  });

  num? cash;
  List<dynamic>? gallaryListSelected;
  double? invNoticeValue;
  int? invoiceId;
  num? net;
  num? noticeCredit;
  num? noticeDebit;
  num? paid;
  num? remain;
  int? returnPurchaseValue;
  int? serial;
  num? tax;
  num? totalAfterTax;
  num? totalBeforeTax;
  num? totalNet;

  factory BalanceInfoDetailModel.fromJson(Map<String, dynamic> json) => BalanceInfoDetailModel(
    cash: json["cash"],
    gallaryListSelected: json["gallaryListSelected"] == null ? null : List<dynamic>.from(json["gallaryListSelected"].map((x) => x)),
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
    totalAfterTax: json["totalAfterTax"],
    totalBeforeTax: json["totalBeforeTax"],
    totalNet: json["totalNet"],
  );

  Map<String, dynamic> toJson() => {
    "cash": cash,
    "gallaryListSelected": gallaryListSelected == null ? null : List<dynamic>.from(gallaryListSelected!.map((x) => x)),
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
    "totalAfterTax": totalAfterTax,
    "totalBeforeTax": totalBeforeTax,
    "totalNet": totalNet,
  };

}