import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';

import 'profit_of_Items_sold_request.dart';

class EditBillsRequest {
  EditBillsRequest({
    required this.serial,
    required this.branchId,
    required this.dateFrom,
    required this.dateTo,


  });
  final int? serial;
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
    this.invInventoryDtoList,

  });

  final int id;
  final int branchId;
   List<DtoList>? invInventoryDtoList;


  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "branchId": branchId,
      "invInventoryDTOList": invInventoryDtoList == null ? null : List<dynamic>.from(invInventoryDtoList!.map((x) => x.toJson())),


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
    this.generalJournalId,
    this.companyId,
    this.gallaryId,
    this.createdBy
  });

  DateTime ?date;
  String ?remark;
  num ?customerBalance;
  int ?customerId;
  int ?gallaryId;
  int ?generalJournalId;
  String? customerName;
  List<GlPayDTO>? glPayDTOAPIList;
  int? branchId;
  int ?companyId;
  int ?createdBy;

  static List<GlBankTransactionApi> fromList(List<dynamic> json) => List<GlBankTransactionApi>.from(json.map((e) => GlBankTransactionApi.fromJson(e)));

  factory GlBankTransactionApi.fromJson(Map<String, dynamic> json) => GlBankTransactionApi(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    remark: json["remark"],
    customerBalance: json["customerBalance"],
    gallaryId: json["gallaryId"],
    customerId: json["customerId"],
    generalJournalId: json["generalJournalId"],
    customerName: json["customerName"],
    // glPayDTOAPIList: json["glPayDTOAPIList"] == null ? null : List<GlPayDTO>.from(json["glPayDTOAPIList"].map((x) => x)),
    glPayDTOAPIList: List<GlPayDTO>.from((json["glPayDTOAPIList"]??[]).map((x) => GlPayDTO.fromJson(x))),
    branchId: json["branchId"],
    companyId: json["companyId"],
    createdBy: json["createdBy"],


  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String(),
    "remark": remark,
    "generalJournalId": generalJournalId,
    "customerBalance": customerBalance,
    "customerId": customerId,
    "customerName": customerName,
    "gallaryId": gallaryId,
    // "glPayDTOAPIList": glPayDTOAPIList == null ? null : List<GlPayDTO>.from(glPayDTOAPIList!.map((x) => x)),
    "glPayDTOAPIList": List<dynamic>.from((glPayDTOAPIList??[]).map((x) => x.toJson())),
    "branchId": branchId,
    "companyId": companyId,
    "createdBy":createdBy

  };

}

class AllInvoicesGAllariesRequest {

  AllInvoicesGAllariesRequest({
    required this.id,
    required this.branchId,
    required this.invInventoryDtoList,

  });

  final int id;
  final int branchId;
  final List<dynamic>? invInventoryDtoList;


  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "branchId": branchId,
      "invInventoryDTOList": invInventoryDtoList == null ? null : List<dynamic>.from(invInventoryDtoList!.map((x) => x.toJson())),


    };
  }

}

