import '../../../common/sales_statement_for_the_period.dart';
import '../../invoice_detail_model.dart';

class InvoiceResponse {
  InvoiceResponse({
    required this.type,
    required this.companyId,
    required this.createdBy,
    required this.createdByName,
    required this.createdDate,
    required this.id,
    required this.index,
    required this.serial,
    required this.customerBalance,
    required this.customerCode,
    required this.customerEmail,
    required this.customerId,
    required this.customerMobile,
    required this.customerName,
    required this.customerOfferCompanyId,
    required this.daribaValue,
    required this.date,
    required this.deliveryPlaceName,
    required this.discHalala,
    required this.discount,
    required this.discountType,
    required this.dueDate,
    required this.dueperiod,
    required this.finalNet,
    required this.gallaryId,
    required this.gallaryName,
    required this.invDelegatorId,
    required this.invDelegatorName,
    required this.invInventoryId,
    required this.invInventoryName,
    required this.invoiceDate,
    required this.details,
    required this.invoiceNumber,
    required this.length,
    required this.noticeCredit,
    required this.noticeDebit,
    required this.payed,
    required this.pricetype,
    required this.proof,
    required this.qrCode,
    required this.remain,
    required this.remarks,
    required this.returnPurchaseValue,
    required this.salesStatementForThePeriod,
    required this.segilValue,
    required this.serialTax,
    required this.shoulder,
    required this.status,
    required this.step,
    required this.taxvalue,
    required this.totalNet,
    required this.totalNetAfterDiscount,
  });

  final String type;
  final int companyId;
  final int createdBy;
  final String createdByName;
  final DateTime createdDate;
  final int id;
  final int index;
  final int serial;
  final num customerBalance;
  final String customerCode;
  final String customerEmail;
  final int customerId;
  final String customerMobile;
  final String customerName;
  final String customerOfferCompanyId;
  final String daribaValue;
  final DateTime date;
  final String deliveryPlaceName;
  final double discHalala;
  final num discount;
  final int discountType;
  final DateTime dueDate;
  final int dueperiod;
  final num finalNet;
  final int gallaryId;
  final String gallaryName;
  final int invDelegatorId;
  final String invDelegatorName;
  final int invInventoryId;
  final String invInventoryName;
  final DateTime invoiceDate;
  final List<InvoiceDetailsModel> details;
  final String invoiceNumber;
  final num length;
  final int noticeCredit;
  final int noticeDebit;
  final num payed;
  final int pricetype;
  final int proof;
  final String qrCode;
  final num remain;
  final String remarks;
  final num returnPurchaseValue;
  final SalesStatementForThePeriod salesStatementForThePeriod;
  final String segilValue;
  final num serialTax;
  final num shoulder;
  final String status;
  final num step;
  final num taxvalue;
  final num totalNet;
  final num totalNetAfterDiscount;

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) => InvoiceResponse(
    type: json["type"],
    companyId: json["companyId"],
    createdBy: json["createdBy"],
    createdByName: json["createdByName"],
    createdDate: DateTime.parse(json["createdDate"]),
    id: json["id"],
    index: json["index"],
    serial: json["serial"],
    customerBalance: json["customerBalance"],
    customerCode: json["customerCode"],
    customerEmail: json["customerEmail"],
    customerId: json["customerId"],
    customerMobile: json["customerMobile"],
    customerName: json["customerName"],
    customerOfferCompanyId: json["customerOfferCompanyId"],
    daribaValue: json["daribaValue"],
    date: DateTime.parse(json["date"]),
    deliveryPlaceName: json["deliveryPlaceName"],
    discHalala: json["discHalala"].toDouble(),
    discount: json["discount"],
    discountType: json["discountType"],
    dueDate: DateTime.parse(json["dueDate"]),
    dueperiod: json["dueperiod"],
    finalNet: json["finalNet"],
    gallaryId: json["gallaryId"],
    gallaryName: json["gallaryName"],
    invDelegatorId: json["invDelegatorId"],
    invDelegatorName: json["invDelegatorName"],
    invInventoryId: json["invInventoryId"],
    invInventoryName: json["invInventoryName"],
    invoiceDate: DateTime.parse(json["invoiceDate"]),
    details: List<InvoiceDetailsModel>.from(json["invoiceDetailApiList"].map((x) => InvoiceDetailsModel.fromJson(x))),
    invoiceNumber: json["invoiceNumber"],
    length: json["length"],
    noticeCredit: json["noticeCredit"],
    noticeDebit: json["noticeDebit"],
    payed: json["payed"],
    pricetype: json["pricetype"],
    proof: json["proof"],
    qrCode: json["qrCode"],
    remain: json["remain"],
    remarks: json["remarks"],
    returnPurchaseValue: json["returnPurchaseValue"],
    salesStatementForThePeriod: SalesStatementForThePeriod.fromJson(json["salesStatementForThePeriod"]),
    segilValue: json["segilValue"],
    serialTax: json["serialTax"],
    shoulder: json["shoulder"],
    status: json["status"],
    step: json["step"],
    taxvalue: json["taxvalue"],
    totalNet: json["totalNet"],
    totalNetAfterDiscount: json["totalNetAfterDiscount"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "companyId": companyId,
    "createdBy": createdBy,
    "createdByName": createdByName,
    "createdDate": createdDate.toIso8601String(),
    "id": id,
    "index": index,
    "serial": serial,
    "customerBalance": customerBalance,
    "customerCode": customerCode,
    "customerEmail": customerEmail,
    "customerId": customerId,
    "customerMobile": customerMobile,
    "customerName": customerName,
    "customerOfferCompanyId": customerOfferCompanyId,
    "daribaValue": daribaValue,
    "date": date.toIso8601String(),
    "deliveryPlaceName": deliveryPlaceName,
    "discHalala": discHalala,
    "discount": discount,
    "discountType": discountType,
    "dueDate": dueDate.toIso8601String(),
    "dueperiod": dueperiod,
    "finalNet": finalNet,
    "gallaryId": gallaryId,
    "gallaryName": gallaryName,
    "invDelegatorId": invDelegatorId,
    "invDelegatorName": invDelegatorName,
    "invInventoryId": invInventoryId,
    "invInventoryName": invInventoryName,
    "invoiceDate": invoiceDate.toIso8601String(),
    "invoiceDetailApiList": List<dynamic>.from(details.map((x) => x.toJson())),
    "invoiceNumber": invoiceNumber,
    "length": length,
    "noticeCredit": noticeCredit,
    "noticeDebit": noticeDebit,
    "payed": payed,
    "pricetype": pricetype,
    "proof": proof,
    "qrCode": qrCode,
    "remain": remain,
    "remarks": remarks,
    "returnPurchaseValue": returnPurchaseValue,
    "salesStatementForThePeriod": salesStatementForThePeriod.toJson(),
    "segilValue": segilValue,
    "serialTax": serialTax,
    "shoulder": shoulder,
    "status": status,
    "step": step,
    "taxvalue": taxvalue,
    "totalNet": totalNet,
    "totalNetAfterDiscount": totalNetAfterDiscount,
  };
}