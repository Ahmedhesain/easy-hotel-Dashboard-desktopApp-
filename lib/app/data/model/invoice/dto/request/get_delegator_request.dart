class DelegatorRequest {
  DelegatorRequest({
    this.gallaryId,
    this.branchId,
  });

  int? gallaryId;
  int? branchId;

  Map<String, dynamic> toJson() => {
        "gallaryId": gallaryId,
        "branchId": branchId,
      };
}
