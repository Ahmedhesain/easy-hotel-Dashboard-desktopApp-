import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';

class InvoiceStatementByCaseRequest {
  InvoiceStatementByCaseRequest({
    this.gallaryListSelected,
    required this.branchId,
    required this.dateFrom,
    required this.dateTo,
    // required this.dayNumbers,
    required this.invoiceStatus,

  });
   List<dynamic>? gallaryListSelected;
  final int branchId;
  final DateTime dateFrom;
  final DateTime dateTo;
  // final int dayNumbers;
  final int invoiceStatus;


  Map<String, dynamic> toJson(){
    return {
      "gallaryListSelected": gallaryListSelected == null ? null : List<dynamic>.from(gallaryListSelected!.map((x) => x.toJson())),
      "branchId": branchId,
      "dateFrom": dateFrom.toIso8601String(),
      "dateTo": dateTo.toIso8601String(),
      // "dayNumbers": dayNumbers,
      "invoiceStatus": invoiceStatus
    };
  }

}
