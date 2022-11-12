class GetInvoiceRequest {
  GetInvoiceRequest({
    required this.branchId,
    required this.serial,
    required this.gallaryId,
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