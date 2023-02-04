import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';

class PurchasesRequest {
  PurchasesRequest({
     this.gallaryList,
    required this.branchId,
    required this.dateFrom,
    required this.dateTo,
    required this.invoiceType,
    required this.frompaymentType,
    required this.topaymentType,

  });
   List<dynamic> ? gallaryList;
  final int branchId;
  final DateTime dateFrom;
  final DateTime dateTo;
  final int invoiceType;
  final int frompaymentType;
  final int topaymentType;


  Map<String, dynamic> toJson(){
    return {
      "gallaryList": gallaryList == null ? null : List<dynamic>.from(gallaryList!.map((x) => x.toJson())),
      "branchId": branchId,
      "dateFrom": dateFrom.toIso8601String(),
      "dateTo": dateTo.toIso8601String(),
      "invoiceType": invoiceType,
      "frompaymentType": frompaymentType,
      "topaymentType": topaymentType
    };
  }

}
