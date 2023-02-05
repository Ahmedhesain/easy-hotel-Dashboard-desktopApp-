


import '../../../reports/dto/response/categories_totals_response.dart';

class BranchReportResponse {
  final int? gallaryId;
  final String? gallaryName;
  final int? invoiceNumber;
  final num? invoiceValue;
  final num? allCustomer;
  final num? allNewCustomer;
   num? allCostAverage;
  final List<CategoriesTotalsResponse>? summitionItemsViewList ;

  BranchReportResponse(
      {this.gallaryId,
      this.gallaryName,
      this.invoiceNumber,
      this.invoiceValue,
      this.allCustomer,
      this.allNewCustomer,
      this.summitionItemsViewList,
        this.allCostAverage = 0.0
      });


  factory BranchReportResponse.fromJson(Map<String , dynamic> json) =>BranchReportResponse(
    gallaryId: json["gallaryId"],
    gallaryName: json["gallaryName"],
    invoiceNumber: json["invoiceNumber"],
    invoiceValue: json["invoiceValue"],
    allCustomer: json["allCustomer"],
    allCostAverage: json["allCostAverage"],
    allNewCustomer: json["allNewCustomer"],
    summitionItemsViewList: CategoriesTotalsResponse.fromList(json["summitionItemsViewList"]),
  );
}