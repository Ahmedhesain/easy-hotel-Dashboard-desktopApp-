class CreateCustomerRequest {
  CreateCustomerRequest({
    this.name,
    this.mobile,
    this.email,
    this.length,
    this.shoulder,
    this.step,
    this.branchId,
    this.createdBy,
    this.companyId,
    this.accountIdAPI,
    this.gallaryIdAPI,
  });

  String? name;
  String? mobile;
  String? email;
  num? length;
  num? shoulder;
  num? step;
  int? branchId;
  int? createdBy;
  int? companyId;
  int? accountIdAPI;
  int? gallaryIdAPI;

  Map<String, dynamic> toJson() => {
    "name" : name,
    "mobile": mobile,
    "email": email,
    "length": length,
    "shoulder": shoulder,
    "step": step,
    "branchId": branchId,
    "createdBy": createdBy,
    "accountIdAPI": accountIdAPI,
    "companyId": companyId,
    "gallaryIdAPI": gallaryIdAPI,
  };

}
