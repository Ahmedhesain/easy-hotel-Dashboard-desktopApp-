class InvoiceStatusRequest {

  InvoiceStatusRequest({
    this.branchId,
    this.gallaryId,
    this.serial,
  });

  int? branchId;
  int? gallaryId;
  int? serial;

  Map<String, dynamic> toJson() => {
    "branchId" : branchId,
    "serial" : serial,
    "gallaryId": gallaryId
  };

}
