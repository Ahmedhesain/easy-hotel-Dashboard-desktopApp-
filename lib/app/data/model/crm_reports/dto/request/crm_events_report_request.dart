


class CrmEventsReportRequest {
  final int gallaryId ;
  final int branchId ;
  final DateTime? dateFrom ;
  final DateTime? dateTo ;

  CrmEventsReportRequest({required this.gallaryId,required this.branchId,required this.dateFrom,required this.dateTo});


  Map<String , dynamic> toJson() => {
    'gallaryId' : gallaryId ,
    'branchId' : branchId ,
    'dateFrom' : dateFrom?.toIso8601String(),
    'dateTo' : dateTo?.toIso8601String(),
  };
}