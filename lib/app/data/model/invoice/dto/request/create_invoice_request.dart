import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_due_date_response.dart';
import 'package:toby_bills/app/data/model/invoice/invoice_detail_model.dart';

class CreateInvoiceRequest {

  final num? discountHalala;
  final String? offerCopoun;
  final int? invDelegatorId;
  final int? pricetype;
  final DateTime? date;
  final GetDueDateResponse? dueDate;
  final int? gallaryDeliveryId;
  final String? gallaryDeliveryName;
  final String? gallaryName;
  final int? invoiceType;
  final int? dueperiod;
  final String? remarks;
  final int? id;
  final int? customerId;
  final String? customerName;
  final String? customerCode;
  final String? customerMobile;
  final List<InvoiceDetailsModel>? invoiceDetailApiList;
  List<InvoiceDetailsModel>? invoiceDetailApiListDeleted = [];
  final List<GlPayDTO>? glPayDTOList;
  final int? companyId;
  final int? branchId;
  final int? createdBy;
  final DateTime? createdDate;
  final int? proof;
  final int? invInventoryId;
  final int? gallaryId;
  final num? totalNetAfterDiscount;
  final num? finalNet;
  final num? taxvalue;
  final int? checkSendSms;
  final int? serial;

  CreateInvoiceRequest({
    this.discountHalala,
    this.offerCopoun,
    this.serial,
    this.invDelegatorId,
    this.pricetype,
    this.date,
    this.dueDate,
    this.gallaryDeliveryId,
    this.gallaryDeliveryName,
    this.gallaryName,
    this.invoiceType,
    this.dueperiod,
    this.remarks,
    this.customerId,
    this.id,
    this.customerName,
    this.customerCode,
    this.customerMobile,
    this.invoiceDetailApiList,
    this.invoiceDetailApiListDeleted,
    this.glPayDTOList,
    this.createdBy,
    this.companyId,
    this.branchId,
    this.createdDate,
    this.proof,
    this.invInventoryId,
    this.gallaryId,
    this.totalNetAfterDiscount,
    this.finalNet,
    this.taxvalue,
    this.checkSendSms,
  });

  Map<String, dynamic> toJson() => {
    // "proFactoryDeliveryId": proFactoryDeliveryId,
    // "gallaryPhone": gallaryPhone,
    // "loadedSerial": loadedSerial,
    // "numberOfToob": numberOfToob,
    // "supplierDate": supplierDate?.toIso8601String(),
    // "invPurchaseInvoice": invPurchaseInvoice,
    // "noticeDebit": noticeDebit == null ? null : noticeDebit,
    // "noticeCredit": noticeCredit == null ? null : noticeCredit,
    // "remain": remain == null ? null : remain,
    // "totalNet": totalNet == null ? null : totalNet,
    // "returnPurchaseValue": returnPurchaseValue == null ? null : returnPurchaseValue,
    // "type": type == null ? null : type,
    "companyId": companyId,
    "createdBy": createdBy,
    // "createdByName": createdByName == null ? null : createdByName,
    "createdDate": createdDate?.toIso8601String(),
    "id": id == null ? null : id,
    // "index": index == null ? null : index,
    // "markEdit": markEdit == null ? null : markEdit,
    // "serial": serial == null ? null : serial,
    // "customerBalance": customerBalance == null ? null : customerBalance,
    "customerCode": customerCode,
    // "customerEmail": customerEmail == null ? null : customerEmail,
    "customerId": customerId,
    "customerMobile": customerMobile,
    "customerName": customerName,
    "date": date?.toIso8601String(),
    // "discHalala": discHalala == null ? null : discHalala,
    // "discount": discount == null ? null : discount,
    // "discountType": discountType == null ? null : discountType,
    "dueDate": dueDate?.toJson(),
    "dueperiod": dueperiod,
    "gallaryId": gallaryId,
    "gallaryName": gallaryName,
    "invDelegatorId": invDelegatorId,
    // "invDelegatorName": invDelegatorName == null ? null : invDelegatorName,
    "invInventoryId": invInventoryId,
    // "invInventoryName": invInventoryName == null ? null : invInventoryName,
    // "invoiceDate": invoiceDate == null ? null : invoiceDate!.toIso8601String(),
    "invoiceDetailApiList": invoiceDetailApiList?.map((e) => e.toJson()).toList(),
    "invoiceDetailApiListDeleted": invoiceDetailApiListDeleted?.map((e) => e.toJson()).toList(),

    "glPayDTOList": glPayDTOList?.map((e) => e.toJson()).toList(),
    // "invoiceNumber": invoiceNumber == null ? null : invoiceNumber,
    // "length": length == null ? null : length,
    "offerCopoun": offerCopoun,
    "pricetype": pricetype,
    "proof": proof,
    "remarks": remarks,
    // "serialTax": serialTax == null ? null : serialTax,
    // "shoulder": shoulder == null ? null : shoulder,
    // "status": status == null ? null : status,
    // "step": step == null ? null : step,
    "gallaryDeliveryId": gallaryDeliveryId,
    "gallaryDeliveryName": gallaryDeliveryName,
    "invoiceType": invoiceType,
    "totalNetAfterDiscount": totalNetAfterDiscount,
    "finalNet": finalNet,
    "taxvalue": taxvalue,
    "serial": serial,
    // "payed": payed,
    "branchId": branchId,
    // "salesStatementForThePeriod": salesStatementForThePeriod == null ? null : salesStatementForThePeriod!.toJson(),
  };
}
