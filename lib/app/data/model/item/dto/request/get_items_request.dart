class GetItemRequest {
  GetItemRequest({
    this.branchId
  });

  int? branchId;

  Map<String, dynamic> toJson() => {
    "branchId" : branchId
  };

}
