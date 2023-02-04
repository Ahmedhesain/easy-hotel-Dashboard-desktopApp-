class AccountSummaryRequest {
  AccountSummaryRequest({
    this.glYearId,
    this.branchId,
    this.glaccountId,
    this.costCenterFrom,
    this.costCenterTo,
    this.adminUnitFrom,
    this.adminUnitTo,
    this.dateFrom,
    this.dateTo,
  });

  final int? glYearId;
  final int? branchId;
  final int? glaccountId;
  final int? costCenterFrom;
  final int? costCenterTo;
  final String? adminUnitFrom;
  final String? adminUnitTo;
  final DateTime? dateFrom;
  final DateTime? dateTo;


  Map<String, dynamic> toJson() => {
    "glYearId": glYearId,
    "branchId": branchId,
    "glaccountId": glaccountId,
    "costCenterFrom": costCenterFrom,
    "costCenterTo": costCenterTo,
    "adminUnitFrom": adminUnitFrom,
    "adminUnitTo": adminUnitTo,
    "dateFrom": dateFrom?.toIso8601String(),
    "dateTo": dateTo?.toIso8601String(),
  };
}
