import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';

class PurchasesRequest {
  PurchasesRequest({
    required this.gallaryList,
    required this.branchId,
    required this.dateFrom,
    required this.dateTo,
    required this.invoiceType,
    required this.frompaymentType,
    required this.topaymentType,

  });
  final List<GalleryResponse> gallaryList;
  final int branchId;
  final DateTime dateFrom;
  final DateTime dateTo;
  final int invoiceType;
  final int frompaymentType;
  final int topaymentType;


  Map<String, dynamic> toJson(){
    return {
      "gallaryList" :gallaryList.map((e) => {"id" : e.id}).toList(),
      "serial": branchId,
      "dateFrom": dateFrom.toIso8601String(),
      "dateTo": dateTo.toIso8601String(),
      "invoiceType": invoiceType,
      "frompaymentType": frompaymentType,
      "topaymentType": topaymentType
    };
  }

}
