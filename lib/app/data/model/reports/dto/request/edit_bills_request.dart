import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';

class EditBillsRequest {
  EditBillsRequest({
    required this.serial,
    required this.branchId,
    required this.dateFrom,
    required this.dateTo,


  });
  final int serial;
  final int branchId;
  final DateTime ?dateFrom;
  final DateTime ?dateTo;



  Map<String, dynamic> toJson(){
    return {

      "serial": serial,
      "branchId": branchId,
      "dateFrom": dateFrom == null ? null : dateFrom?.toIso8601String(),
      "dateTo": dateTo == null ? null : dateTo?.toIso8601String(),

    };
  }

}

class AllInvoicesRequest {

  AllInvoicesRequest({
    required this.id,
    required this.branchId,
  });

  final int id;
  final int branchId;

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "branchId": branchId,
    };
  }

}

class GlBankTransactionApi {
  GlBankTransactionApi({
    this.date,
    this.remark,
    this.customerBalance,
    this.customerId,
    this.customerName,
    this.glPayDTOAPIList,
    this.branchId,
    this.companyId,
    this.createdBy
  });

  DateTime ?date;
  String ?remark;
  num ?customerBalance;
  int ?customerId;
  String? customerName;
  List<GlPayDTO>? glPayDTOAPIList;
  int? branchId;
  int ?companyId;
  int ?createdBy;



  static List<GlBankTransactionApi> fromList(List<dynamic> json) => List<GlBankTransactionApi>.from(json.map((e) => GlBankTransactionApi.fromJson(e)));

  factory GlBankTransactionApi.fromJson(Map<String, dynamic> json) => GlBankTransactionApi(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    remark: json["remark"] == null ? null : json["remark"],
    customerBalance: json["customerBalance"] == null ? null : json["customerBalance"],
    customerId: json["customerId"] == null ? null : json["customerId"],
    customerName: json["customerName"] == null ? null : json["customerName"],
    // glPayDTOAPIList: json["glPayDTOAPIList"] == null ? null : List<GlPayDTO>.from(json["glPayDTOAPIList"].map((x) => x)),
    glPayDTOAPIList: json["glPayDTOAPIList"] == null ? null : List<GlPayDTO>.from(json["glPayDTOAPIList"].map((x) => GlPayDTO.fromJson(x))),
    branchId: json["branchId"] == null ? null : json["branchId"],
    companyId: json["companyId"] == null ? null : json["companyId"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],


  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : date!.toIso8601String(),
    "remark": remark == null ? null : remark,
    "customerBalance": customerBalance == null ? null : customerBalance,
    "customerId": customerId == null ? null : customerId,
    "customerName": customerName == null ? null : customerName,
    // "glPayDTOAPIList": glPayDTOAPIList == null ? null : List<GlPayDTO>.from(glPayDTOAPIList!.map((x) => x)),
    "glPayDTOAPIList": glPayDTOAPIList == null ? null : List<GlPayDTO>.from(glPayDTOAPIList!.map((x) => x.toJson())),
    "branchId": branchId == null ? null : branchId,
    "companyId": companyId == null ? null : companyId,
    "createdBy":createdBy == null ? null : createdBy

  };

}
