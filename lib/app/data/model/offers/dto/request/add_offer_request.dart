


import 'add_offer_detail_request.dart';

class AddOfferRequest {

  final String? name;

  final String? msg;

  final DateTime? dateFrom;

  final DateTime? dateTo;

  final int? offerType;

  final int? offerMin;

  final double? offerMax;

  final int? groupId;
  final int? branchId;
  final int? companyId;
  final int? createdBy;

  final double? offerValue;

  final double? sellPrice;

  final List<AddOfferDetailRequest>? details ;

  AddOfferRequest(
      {this.name,
      this.msg,
      this.dateFrom,
      this.dateTo,
      this.offerType,
      this.offerMin,
      this.offerMax,
      this.groupId,
      this.offerValue,
      this.sellPrice,
      this.details,
        this.branchId,
        this.createdBy,
        this.companyId
      });

  Map<String , dynamic> toJson() => {
    "name" : name ,
    "msg" : msg ,
    "dateFrom" : dateFrom?.toIso8601String() ,
    "dateTo" : dateTo?.toIso8601String() ,
    "offerType" : offerType ,
    "offerMin" : offerMin ,
    "offerMax" : offerMax ,
    "groupId" : groupId ,
    "offerValue" : offerValue ,
    "sellPrice" : sellPrice ,
    "branchId" : branchId ,
    "companyId" : companyId ,
    "createdBy" : createdBy ,
    "details" : List<dynamic>.from(details?.map((e) => e.toJson()) ?? []) ,
  };
}