


class GetOfferRequest {
  final  int? branchId;
  final  int? companyId ;

  GetOfferRequest({this.branchId, this.companyId});

  Map<String, dynamic> toJson() => {
    "branchId" : branchId ,
    "companyId" : companyId ,
  };
}