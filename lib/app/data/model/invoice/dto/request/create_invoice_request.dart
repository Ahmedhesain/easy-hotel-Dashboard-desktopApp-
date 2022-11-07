import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_due_date_response.dart';
import 'package:toby_bills/app/data/model/invoice/invoice_detail_model.dart';

class CreateInvoiceRequest {

  final num? discountHalala;
  final String? offerCopoun;
  final int? invDelegatorId;
  final int? pricetype;
  final DateTime? date;
  final DateTime? dueDate;
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
  final DateTime? supplierDate;
  final int? proof;
  final int? invInventoryId;
  final int? gallaryId;
  final num? totalNetAfterDiscount;
  final num? finalNet;
  final num? taxvalue;
  final int? checkSendSms;
  final int? serial;
  final int? typeInv;
  final int? supplierInvoiceNumber;
  final num? discount;
  final num? discountType;

  CreateInvoiceRequest({
    this.discount,
    this.supplierInvoiceNumber,
    this.typeInv,
    this.supplierDate,
    this.discountHalala,
    this.discountType,
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
    "companyId": companyId,
    "createdBy": createdBy,
    "typeInv": typeInv,
    "createdDate": createdDate?.toIso8601String(),
    "id": id,
    "customerCode": customerCode,
    "customerId": customerId,
    "checkSendSms": checkSendSms,
    "customerMobile": customerMobile,
    "customerName": customerName,
    "date": date?.toIso8601String(),
    "supplierDate": supplierDate?.toIso8601String(),
    "discount": discount,
    "discountType": discountType,
    "dueDate": dueDate?.toIso8601String(),
    "dueperiod": dueperiod,
    "gallaryId": gallaryId,
    "gallaryName": gallaryName,
    "invDelegatorId": invDelegatorId,
    "invInventoryId": invInventoryId,
    "invoiceDetailApiList": invoiceDetailApiList?.map((e) => e.toJson()).toList(),
    "invoiceDetailApiListDeleted": invoiceDetailApiListDeleted?.map((e) => e.toJson()).toList(),
    "glPayDTOList": glPayDTOList?.map((e) => e.toJson()).toList(),
    "offerCopoun": offerCopoun,
    "pricetype": pricetype,
    "proof": proof,
    "remarks": remarks,
    "supplierInvoiceNumber": supplierInvoiceNumber,
    "gallaryDeliveryId": gallaryDeliveryId,
    "gallaryDeliveryName": gallaryDeliveryName,
    "invoiceType": invoiceType,
    "totalNetAfterDiscount": totalNetAfterDiscount,
    "finalNet": finalNet,
    "taxvalue": taxvalue,
    "serial": serial,
    "branchId": branchId,
  };
}
