


import '../../../reports/dto/response/categories_totals_response.dart';

class BranchReportResponse {
  final int? gallaryId;
  final String? gallaryName;
  final int? invoiceNumber;
  final num? invoiceValue;
  final num? allCustomer;
  final num? allNewCustomer;
  final List<CategoriesTotalsResponse>? summitionItemsViewList ;

  BranchReportResponse(
      {this.gallaryId,
      this.gallaryName,
      this.invoiceNumber,
      this.invoiceValue,
      this.allCustomer,
      this.allNewCustomer,
      this.summitionItemsViewList});


  factory BranchReportResponse.fromJson(Map<String , dynamic> json) =>BranchReportResponse(
    gallaryId: json["gallaryId"],
    gallaryName: json["gallaryName"],
    invoiceNumber: json["invoiceNumber"],
    invoiceValue: json["invoiceValue"],
    allCustomer: json["allCustomer"],
    allNewCustomer: json["allNewCustomer"],
    summitionItemsViewList: CategoriesTotalsResponse.fromList(json["summitionItemsViewList"]),
  );
}