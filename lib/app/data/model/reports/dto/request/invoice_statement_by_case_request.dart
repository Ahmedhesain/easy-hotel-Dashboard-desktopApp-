import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';

class InvoiceStatementByCaseRequest {
  InvoiceStatementByCaseRequest({
    required this.gallarySelected,
    required this.branchId,
    required this.dateFrom,
    required this.dateTo,
    required this.dayNumbers,
    required this.invoiceStatus,

  });
  final List<GalleryResponse> gallarySelected;
  final int branchId;
  final DateTime dateFrom;
  final DateTime dateTo;
  final int dayNumbers;
  final int invoiceStatus;


  Map<String, dynamic> toJson(){
    return {
      "gallarySelected": gallarySelected.map((e) => {"id" : e.id}).toList(),
      "branchId": branchId,
      "dateFrom": dateFrom.toIso8601String(),
      "dateTo": dateTo.toIso8601String(),
      "dayNumbers": dayNumbers,
      "invoiceStatus": invoiceStatus
    };
  }

}
