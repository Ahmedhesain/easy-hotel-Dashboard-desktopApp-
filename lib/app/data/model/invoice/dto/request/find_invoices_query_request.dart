class FindInvoicesQueryRequest{

  FindInvoicesQueryRequest({
    required this.gallaryId,
    required this.searchNumber ,
    required this.dateFrom ,
    required this.dateTo,
    this.searchType
  });

  final int gallaryId;
  final String searchNumber;
  final DateTime? dateFrom ;
  final DateTime? dateTo ;
  final int? searchType ;

  Map<String, dynamic> toJson(){
    return {
      "gallaryId": gallaryId,
      "searchNumber": searchNumber,
      "dateFrom" : dateFrom?.toIso8601String() ?? null,
      "dateTo" : dateTo?.toIso8601String() ?? null,
      "searchType" : searchType
    };
  }


}