class GetInvoiceRequest {
  GetInvoiceRequest({
    required this.branchId,
    required this.serial,
    required this.gallaryId,
  });

  int? branchId;
  String? serial;
  int? gallaryId;


  Map<String, dynamic> toJson() => {
    "branchId": branchId,
    "serial": serial,
    "gallaryId": gallaryId,
  };
}