import '../../invoice_detail_model.dart';
import '../gl_pay_dto.dart';

class InvoiceResponse {
  InvoiceResponse(
      {required this.type,
      required this.branchId,
      required this.companyId,
      required this.createdBy,
      required this.createdDate,
      required this.id,
      required this.customerId,
      required this.daribaValue,
      required this.date,
      required this.discount,
      required this.discountType,
      required this.dueperiod,
      required this.finalNet,
      required this.gallaryId,
      required this.invDelegatorId,
      required this.invInventoryId,
      required this.payed,
      required this.pricetype,
      required this.qrCode,
      required this.remarks,
      required this.segilValue,
      required this.taxvalue,
      required this.totalNetAfterDiscount,
      required this.invoiceDetailApiList,
      required this.createdByName,
      required this.index,
      required this.serial,
      required this.customerBalance,
      required this.customerCode,
      required this.customerEmail,
      required this.customerMobile,
      required this.customerName,
      required this.customerOfferCompanyId,
      required this.deliveryPlaceName,
      required this.discHalala,
      required this.dueDate,
      required this.gallaryName,
      required this.invDelegatorName,
      required this.invInventoryName,
      required this.invoiceDate,
      required this.invoiceNumber,
      required this.length,
      required this.noticeCredit,
      required this.noticeDebit,
      required this.proof,
      required this.remain,
      required this.returnPurchaseValue,
      required this.serialTax,
      required this.shoulder,
      required this.status,
      required this.step,
      required this.totalNet});

  final String type;
  final int? branchId;
  final int companyId;
  final int createdBy;
  final DateTime createdDate;
  int id;
  final int customerId;
  final String daribaValue;
  final DateTime date;
  final num discount;
  final int discountType;
  final int dueperiod;
  final num finalNet;
  final int gallaryId;
  final int invDelegatorId;
  final int invInventoryId;
  num payed;
  final int pricetype;
  final String qrCode;
  final String remarks;
  final String segilValue;
  final num taxvalue;
  final num totalNetAfterDiscount;
  final List<InvoiceDetailsModel>? invoiceDetailApiList;

  final String? createdByName;
  final int? index;
  final int? serial;
  final num? customerBalance;
  final String? customerCode;
  final String? customerEmail;
  final String? customerMobile;
  final String? customerName;
  final String? customerOfferCompanyId;
  final String? deliveryPlaceName;
  final double? discHalala;
  final DateTime? dueDate;
  final String? gallaryName;
  final String? invDelegatorName;
  final String? invInventoryName;
  final DateTime? invoiceDate;
  final String? invoiceNumber;
  final num? length;
  final int? noticeCredit;
  final int? noticeDebit;
  final int? proof;
  final num? remain;
  final num? returnPurchaseValue;
  final num? serialTax;
  final num? shoulder;
  final String? status;
  final num? step;
  final num? totalNet;

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

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) => InvoiceResponse(
        type: json["type"],
        branchId: json["branchId"],
        companyId: json["companyId"],
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        id: json["id"],
        customerId: json["customerId"],
        daribaValue: json["daribaValue"],
        date: DateTime.parse(json["date"]),
        discount: json["discount"],
        discountType: json["discountType"],
        dueperiod: json["dueperiod"],
        finalNet: json["finalNet"].toDouble(),
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
        totalNetAfterDiscount: json["totalNetAfterDiscount"],
        step: json["step"],
        status: json["status"],
        shoulder: json["shoulder"],
        serialTax: json["serialTax"],
        returnPurchaseValue: json["returnPurchaseValue"],
        remain: json["remain"],
        totalNet: json["totalNet"],
        proof: json["proof"],
        noticeDebit: json["noticeDebit"],
        noticeCredit: json["noticeCredit"],
        length: json["length"],
        invoiceNumber: json["invoiceNumber"],
        invoiceDate: json["invoiceDate"] == null ? null: DateTime.parse(json["invoiceDate"]),
        invInventoryName: json["invInventoryName"],
        invDelegatorName: json["invDelegatorName"],
        gallaryName: json["gallaryName"],
        dueDate: json["dueDate"] == null?null:DateTime.parse(json["dueDate"]),
        discHalala: json["discHalala"],
        deliveryPlaceName: json["deliveryPlaceName"],
        customerOfferCompanyId: json["customerOfferCompanyId"],
        customerName: json["customerName"],
        customerMobile: json["customerMobile"],
        customerEmail: json["customerEmail"],
        customerCode: json["customerCode"],
        customerBalance: json["customerBalance"],
        serial: json["serial"],
        index: json["index"],
        createdByName: json["createdByName"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "branchId": branchId,
        "companyId": companyId,
        "createdBy": createdBy,
        "createdDate": createdDate.toIso8601String(),
        "id": id,
        "customerId": customerId,
        "daribaValue": daribaValue,
        "date": date.toIso8601String(),
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
        "remarks": remarks,
        "segilValue": segilValue,
        "taxvalue": taxvalue,
        "totalNetAfterDiscount": totalNetAfterDiscount,
      };
}
