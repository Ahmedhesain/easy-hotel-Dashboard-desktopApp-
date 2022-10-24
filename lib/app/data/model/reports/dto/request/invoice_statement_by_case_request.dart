import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';

class InvoiceStatementByCaseRequest {
  InvoiceStatementByCaseRequest({
    required this.gallaryList,
    required this.branchId,
    required this.dateFrom,
    required this.dateTo,
    required this.dayNumber,
    required this.selectedStatus,

  });
  final List<GalleryResponse> gallaryList;
  final int branchId;
  final DateTime dateFrom;
  final DateTime dateTo;
  final int dayNumber;
  final int selectedStatus;


  Map<String, dynamic> toJson(){
    return {
      "gallaryList": gallaryList.map((e) => {"id" : e.id}).toList(),
      "serial": branchId,
      "dateFrom": dateFrom.toIso8601String(),
      "dateTo": dateTo.toIso8601String(),
      "dayNumber": dayNumber,
      "selectedStatus": selectedStatus
    };
  }

}
