


class AddOfferDetailRequest {

  final int itemId;
  final int? status;
  final int addedOrExcluded;
  final int branchId;
  final int companyId;
  final int createdBy;

  AddOfferDetailRequest({
    required this.itemId,
    this.status,
    required this.addedOrExcluded ,
    required this.branchId,
    required this.companyId ,
    required this.createdBy
  });

  Map<String , dynamic>  toJson() => {
    "itemId" : itemId,
    "status" : status,
    "addedOrExcluded" : addedOrExcluded,
    "branchId" : branchId,
    "companyId" : companyId,
    "createdBy" : createdBy,
  };
}