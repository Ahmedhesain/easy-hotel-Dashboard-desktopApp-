


class CustomersReportRequest {
  final List<int?>? gallaryListSelected;
  final List<int?>? offerCompanyListSelected;
  final int? black;
  final int branchId;

  CustomersReportRequest({required this.gallaryListSelected,required this.offerCompanyListSelected,required this.black,required this.branchId});

  Map<String , dynamic> toJson() => {
    "gallaryListSelected" : gallaryListSelected,
    "offerCompanyListSelected" : offerCompanyListSelected,
    "black" : black,
    "branchId" : branchId,
  };
}