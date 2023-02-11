


class DailyAttachSearchRequest {
  final int? gallaryId;
  final int? branchId;
  final DateTime? dateFrom;
  final DateTime? dateTo;

  DailyAttachSearchRequest(
      {this.gallaryId, this.branchId, this.dateFrom, this.dateTo});


  Map<String , dynamic> toJson() => {
    "gallaryId" : gallaryId,
    "branchId" : branchId,
    "dateTo" : dateTo?.toIso8601String(),
    "dateFrom" : dateFrom?.toIso8601String(),
  };
}