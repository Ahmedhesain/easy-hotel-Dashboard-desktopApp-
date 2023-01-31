class CustomerComparisonRequest {
  final DateTime? firstDateFrom;
  final DateTime? secondDateFrom;
  final DateTime? firstDateTo;
  final DateTime? secondDateTo;
  final int? firstCustomer;
  final int? secondCustomer;
  final int? gallaryId;

  CustomerComparisonRequest(
      {this.firstDateFrom,
      this.secondDateFrom,
      this.firstDateTo,
      this.secondDateTo,
      this.firstCustomer,
      this.secondCustomer,
      this.gallaryId});

  Map<String, dynamic> toJson() => {
        "firstDateFrom": firstDateFrom?.toIso8601String(),
        "secondDateFrom": secondDateFrom?.toIso8601String(),
        "firstDateTo": firstDateTo?.toIso8601String(),
        "secondDateTo": secondDateTo?.toIso8601String(),
        "firstCustomer": firstCustomer,
        "secondCustomer": secondCustomer,
        "gallaryId": gallaryId,
      };
}
