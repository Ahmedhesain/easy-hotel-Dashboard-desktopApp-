class GetCostCenterRequest {
  GetCostCenterRequest({
    this.branchId,
  });

  int? branchId;

  Map<String, dynamic> toJson() => {
    "branchId": branchId,
  };
}
