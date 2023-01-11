import '../../invoice_detail_model.dart';
import '../gl_pay_dto.dart';

class InvoiceModel {
  InvoiceModel(
      {this.type,
      this.branchId,
      this.companyId,
      this.createdBy,
      this.customerNotice,
      this.createdDate,
      this.id,
      this.customerId,
      this.daribaValue,
      this.date,
      this.discount,
      this.discountType,
      this.dueperiod,
      this.finalNet,
      this.gallaryId,
      this.invDelegatorId,
      this.invInventoryId,
      this.payed,
      this.pricetype,
      this.qrCode,
      this.remarks,
      this.segilValue,
      this.taxvalue,
      this.totalNetAfterDiscount,
      this.invoiceDetailApiList,
      this.invoiceDetailApiListDeleted,
      this.createdByName,
      this.index,
      this.serial,
      this.customerBalance,
      this.customerCode,
      this.customerEmail,
      this.customerMobile,
      this.customerName,
      this.customerOfferCompanyId,
      this.deliveryPlaceName,
      this.discHalala,
      this.dueDate,
      this.gallaryName,
      this.invDelegatorName,
      this.invInventoryName,
      this.invoiceDate,
      this.invoiceNumber,
      this.length,
      this.checkSendSms,
      this.noticeCredit,
      this.noticeDebit,
      this.proof,
      this.remain,
      this.loadedSerial,
      this.returnPurchaseValue,
      this.serialTax,
      this.invoiceType,
      this.shoulder,
      this.invoiceLastStatus,
      this.status,
      this.invNoticeOrderId,
      this.step,
      this.supplierInvoiceNumber,
      this.generalJournalId,
      this.typeInv,
      this.invNoticeValueTotal,
      this.invPurchaseInvoice,
      this.totalNet,
      this.supplierDate,
      this.msg,
      this.gallaryDeliveryShow,
      this.invoiceStatus,
      this.numberOfToob

      });

  String? type;
  String? customerNotice;
  int? typeInv;
  int? branchId;
  int? companyId;
  String? supplierInvoiceNumber;
  int? createdBy;
  int? generalJournalId;
  DateTime? createdDate;
  int? id;
  int? customerId;
  String? daribaValue;
  DateTime? date;
  num? invNoticeValueTotal;
  num? discount;
  int? discountType;
  int? invNoticeOrderId;
  int? dueperiod;
  num? finalNet;
  int? gallaryId;
  int? invDelegatorId;
  int? invInventoryId;
  num? payed;
  int? pricetype;
  String? qrCode;
  String? remarks;
  String? segilValue;
  num? taxvalue;
  num? totalNetAfterDiscount;
  List<InvoiceDetailsModel>? invoiceDetailApiList = [];
  List<InvoiceDetailsModel>? invoiceDetailApiListDeleted = [];

  String? createdByName;
  String? invoiceLastStatus;
  int? index;
  int? serial;
  num? customerBalance;
  String? customerCode;
  String? customerEmail;
  String? customerMobile;
  String? customerName;
  String? customerOfferCompanyId;
  String? deliveryPlaceName;
  double? discHalala;
  DateTime? dueDate;
  String? gallaryName;
  String? invDelegatorName;
  String? invInventoryName;
  DateTime? invoiceDate;
  String? invoiceNumber;
  num? length;
  num? noticeCredit;
  num? noticeDebit;
  int? proof;
  bool? checkSendSms;
  num? remain;
  num? returnPurchaseValue;
  num? serialTax;
  num? shoulder;
  String? status;
  num? step;
  num? totalNet;

  num? numberOfToob;
  num? loadedSerial;
  String? gallaryPhone;
  DateTime? supplierDate;
  int? invPurchaseInvoice;
  String? invoiceStatus;
  bool? markEdit;
  int? invoiceType;
  int? gallaryDeliveryId;
  String? gallaryDeliveryName;
  List<GlPayDTO>? glPayDTOList;
  String? offerCopoun;
  int? proFactoryDeliveryId;
  String? msg;

  int? gallaryDeliveryShow;

  static List<InvoiceModel> fromList(List<dynamic> json) => List<InvoiceModel>.from(json.map((e) => InvoiceModel.fromJson(e)));

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        type: json["type"],
        invoiceLastStatus: json["invoiceLastStatus"],
        customerNotice: json["customerNotice"],
        branchId: json["branchId"],
        serial: json["serial"],
        companyId: json["companyId"],
        loadedSerial: json["loadedSerial"],
        invNoticeValueTotal: json["invNoticeValueTotal"],
        generalJournalId: json["generalJournalId"],
        supplierInvoiceNumber: json["supplierInvoiceNumber"],
        createdBy: json["createdBy"],
        invoiceType: json["invoicetype"],
        createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
        id: json["id"],
        typeInv: json["typeInv"],
        customerId: json["customerId"],
        daribaValue: json["daribaValue"],
        invNoticeOrderId: json["invNoticeOrderId"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        invPurchaseInvoice: json["invPurchaseInvoice"],
        discount: json["discount"],
        discountType: json["discountType"],
        dueperiod: json["dueperiod"],
        finalNet: json["finalNet"]?.toDouble(),
        gallaryId: json["gallaryId"],
        invDelegatorId: json["invDelegatorId"],
        invInventoryId: json["invInventoryId"],
        payed: json["payed"],
        pricetype: json["pricetype"],
        qrCode: json["qrCode"],
        remarks: json["remarks"],
        segilValue: json["segilValue"],
        taxvalue: json["taxvalue"],
        invoiceDetailApiList: List<InvoiceDetailsModel>.from((json["invoiceDetailApiList"] ?? []).map((e) => InvoiceDetailsModel.fromJson(e))),
        invoiceDetailApiListDeleted:
            List<InvoiceDetailsModel>.from((json["invoiceDetailApiListDeleted"] ?? []).map((e) => InvoiceDetailsModel.fromJson(e))),
        totalNetAfterDiscount: json["totalNetAfterDiscount"],
        step: json["step"],
        status: json["status"],
        shoulder: json["shoulder"],
        serialTax: json["serialTax"],
        checkSendSms: json["checkSendSms"],
        returnPurchaseValue: json["returnPurchaseValue"],
        remain: json["remain"],
        totalNet: json["totalNet"],
        proof: json["proof"],
        noticeDebit: json["noticeDebit"],
        noticeCredit: json["noticeCredit"],
        length: json["length"],
        invoiceNumber: json["invoiceNumber"],
        invoiceDate: json["invoiceDate"] == null ? null : DateTime.parse(json["invoiceDate"]),
        supplierDate: json["supplierDate"] == null ? null : DateTime.parse(json["supplierDate"]),
        invInventoryName: json["invInventoryName"],
        invDelegatorName: json["invDelegatorName"],
        gallaryName: json["gallaryName"],
        dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
        discHalala: json["discHalala"],
        deliveryPlaceName: json["deliveryPlaceName"],
        customerOfferCompanyId: json["customerOfferCompanyId"],
        customerName: json["customerName"],
        customerMobile: json["customerMobile"],
        customerEmail: json["customerEmail"],
        customerCode: json["customerCode"],
        customerBalance: json["customerBalance"],
        index: json["index"],
        createdByName: json["createdByName"],
        msg: json["msg"],
        gallaryDeliveryShow: json["gallaryDeliveryShow"],
        invoiceStatus: json["invoiceStatus"],
        numberOfToob: json["numberOfToob"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "invoiceLastStatus": invoiceLastStatus,
        "loadedSerial": loadedSerial,
        "invNoticeValueTotal": invNoticeValueTotal,
        "supplierInvoiceNumber": supplierInvoiceNumber,
        "branchId": branchId,
        "companyId": companyId,
        "generalJournalId": generalJournalId,
        "invNoticeOrderId": invNoticeOrderId,
        "typeInv": typeInv,
        "createdBy": createdBy,
        "customerNotice": customerNotice,
        "createdDate": createdDate?.toIso8601String(),
        "id": id,
        "customerId": customerId,
        "invPurchaseInvoice": invPurchaseInvoice,
        "daribaValue": daribaValue,
        "date": date?.toIso8601String(),
        "discount": discount,
        "discountType": discountType,
        "dueperiod": dueperiod,
        "finalNet": finalNet,
        "gallaryId": gallaryId,
        "invDelegatorId": invDelegatorId,
        "invInventoryId": invInventoryId,
        "payed": payed,
        "pricetype": pricetype,
        "qrCode": qrCode,
        "checkSendSms": checkSendSms,
        "remarks": remarks,
        "segilValue": segilValue,
        "taxvalue": taxvalue,
        "supplierDate:": supplierDate?.toIso8601String(),
        "invoicetype": invoiceType,
        "proof": proof,
        "serial": serial,
        "msg": msg,
        "gallaryDeliveryShow": gallaryDeliveryShow,
        "totalNetAfterDiscount": totalNetAfterDiscount,
        "invoiceDetailApiList": invoiceDetailApiList?.map((e) => e.toJson()).toList(),
        "invoiceDetailApiListDeleted": invoiceDetailApiListDeleted?.map((e) => e.toJson()).toList(),
      };
}
