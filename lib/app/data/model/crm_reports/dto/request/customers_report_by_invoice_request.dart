


class CustomersReportByInvoiceRequest {
  final List<int?>? gallarySelected;
  final DateTime? invoiceDateFrom;
  final DateTime? invoiceDateTo;
  final double? invoiceValueFrom;
  final double? invoiceValueTo;
  final int? thobeNumberFrom;
  final int? thobeNumberTo;
  final int? branchId;
  final int? findTotal;

  CustomersReportByInvoiceRequest(
      {required this.gallarySelected,
      required this.invoiceDateFrom,
      required this.invoiceDateTo,
      required this.invoiceValueFrom,
      required this.invoiceValueTo,
      required this.thobeNumberFrom,
      required this.thobeNumberTo,
      required this.branchId,
      this.findTotal});

  Map<String , dynamic> toJson() => {
    "gallarySelected" : gallarySelected,
    "invoiceDateFrom" : invoiceDateFrom?.toIso8601String(),
    "invoiceDateTo" : invoiceDateTo?.toIso8601String(),
    "invoiceValueFrom" : invoiceValueFrom,
    "invoiceValueTo" : invoiceValueTo,
    "thobeNumberFrom" : thobeNumberFrom,
    "thobeNumberTo" : thobeNumberTo,
    "branchId" : branchId,
    "findTotal" : findTotal,
  };
}