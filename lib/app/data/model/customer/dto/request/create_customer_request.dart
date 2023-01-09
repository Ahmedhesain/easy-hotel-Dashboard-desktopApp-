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
    this.countrySubentity,
    this.postalZone,
    this.citySubdivisionName,
    this.plotIdentification,
    this.buildingNumber,
    this.additionalStreetName,
    this.nationId,
    this.passport,
    this.streeName,
    this.taxNumber
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
   String? taxNumber;
   String? nationId;
   String? passport;
   String? streeName;
   String? additionalStreetName;
   String? buildingNumber;
   String? plotIdentification;
   String? citySubdivisionName;
   String? postalZone;
   String? countrySubentity;

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
    "taxNumber": taxNumber,
    "nationId": nationId,
    "passport": passport,
    "streeName": streeName,
    "additionalStreetName": additionalStreetName,
    "buildingNumber": buildingNumber,
    "plotIdentification": plotIdentification,
    "citySubdivisionName": citySubdivisionName,
    "postalZone": postalZone,
    "countrySubentity": countrySubentity,
  };

}
