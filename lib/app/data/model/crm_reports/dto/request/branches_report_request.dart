


class BranchesReportRequest {
  final int? invoiceStatus;
  final int? gallaryFrom;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int? dayNumbers;
  final int? branchId;

  BranchesReportRequest(
      {this.invoiceStatus,
      this.gallaryFrom,
      this.fromDate,
      this.toDate,
      this.dayNumbers,
      this.branchId});

  Map<String,dynamic> toJson () => {
    "invoiceStatus" : invoiceStatus,
    "gallaryFrom" : gallaryFrom,
    "fromDate" : fromDate?.toIso8601String(),
    "toDate" : toDate?.toIso8601String(),
    "dayNumbers" : dayNumbers,
    "branchId" : branchId,
  };
}