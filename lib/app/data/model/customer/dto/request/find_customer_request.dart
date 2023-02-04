class FindCustomerRequest {
  FindCustomerRequest({
    this.branchId,
    this.code,
    this.gallaryIdAPI,
  });

  int? branchId;
  String? code;
  int? gallaryIdAPI;

  Map<String, dynamic> toJson() => {
    "branchId" : branchId,
    "code": code,
    "gallaryIdAPI":gallaryIdAPI
  };

}
