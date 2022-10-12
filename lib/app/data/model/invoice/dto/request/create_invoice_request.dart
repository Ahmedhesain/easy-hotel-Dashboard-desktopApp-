import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_due_date_response.dart';
import 'package:toby_bills/app/data/model/invoice/invoice_detail_model.dart';

class CreateInvoiceRequest {

  CreateInvoiceRequest({
    this.discountHalala,
    this.offerCopoun,
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
    this.customerName,
    this.customerCode,
    this.customerMobile,
    this.invoiceDetailApiList,
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
    this.discount,
    this.discountType,
  });

  final num? discountHalala;
  final num? discountType;
  final num? discount;
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
  final int? customerId;
  final String? customerName;
  final String? customerCode;
  final String? customerMobile;
  final List<InvoiceDetailsModel>? invoiceDetailApiList;
  final List<GlPayDTO>? glPayDTOList;
  final int? createdBy;
  final int? companyId;
  final int? branchId;
  final DateTime? createdDate;
  final int? proof;
  final int? invInventoryId;
  final int? gallaryId;
  final num? totalNetAfterDiscount;
  final num? finalNet;
  final num? taxvalue;
  final int? checkSendSms;

  Map<String, dynamic> toJson() => {
    "companyId": companyId,
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "customerCode": customerCode,
    "customerId": customerId,
    "customerMobile": customerMobile,
    "customerName": customerName,
    "date": date?.toIso8601String(),
    "discount": discount == null ? null : discount,
    "discountType": discountType == null ? null : discountType,
    "dueDate": dueDate?.toJson(),
    "dueperiod": dueperiod,
    "gallaryId": gallaryId,
    "gallaryName": gallaryName,
    "invDelegatorId": invDelegatorId,
    "invInventoryId": invInventoryId,
    "invoiceDetailApiList": invoiceDetailApiList?.map((e) => e.toJson()).toList(),
    "glPayDTOList": glPayDTOList?.map((e) => e.toJson()).toList(),
    "invoiceNumber": invoiceNumber == null ? null : invoiceNumber,
    "length": length == null ? null : length,
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
    // "payed": payed,
    "branchId": branchId,
    "discount": discount,
    "discountType": discountType,
    // "salesStatementForThePeriod": salesStatementForThePeriod == null ? null : salesStatementForThePeriod!.toJson(),
  };
}
