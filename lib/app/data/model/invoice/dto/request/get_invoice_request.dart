class GetInvoiceRequest {
  GetInvoiceRequest({
    this.branchId,
    this.serial,
    this.gallaryId,
    this.typeInv,
  });

  int? branchId;
  String? serial;
  int? gallaryId;
  int? typeInv;


  Map<String, dynamic> toJson() => {
    "branchId": branchId,
    "serial": serial,
    "gallaryId": gallaryId,
    "typeInv": typeInv,
  };
}
class GetAllInvoiceRequest {
  GetAllInvoiceRequest({
    this.branchId,
    this.organizationSiteId,

  });

  int? branchId;
  int? organizationSiteId;



  Map<String, dynamic> toJson() => {
    "branchId": branchId,
    "organizationSiteId": organizationSiteId,

  };
}