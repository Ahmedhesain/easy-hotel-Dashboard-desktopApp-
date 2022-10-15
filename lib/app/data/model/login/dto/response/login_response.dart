class LoginResponse{
LoginResponse({
    required this.accountIdApi,
    required this.branchSelected,
    required this.companySelected,
    required this.galleryId,
    required this.galleryName,
    required this.galleryType,
    required this.id,
    required this.name,
  });

  int accountIdApi;
  int branchSelected;
  int companySelected;
  int galleryId;
  String galleryName;
  int galleryType;
  int id;
  String name;

  factory LoginResponse.fromJson(Map<String, dynamic> data) {
    Map<String, dynamic> json = data.containsKey("data")?data["data"]:data;
    return LoginResponse(
    accountIdApi: json["accountIdAPI"],
    branchSelected: json["branchSelected"],
    companySelected: json["companySelected"],
    galleryId: json["galleryId"],
    galleryName: json["galleryName"],
    galleryType: json["galleryType"],
    id: json["id"],
    name: json["name"],
  );
  }

  Map<String, dynamic> toJson() => {
    "accountIdAPI": accountIdApi,
    "branchSelected": branchSelected,
    "companySelected": companySelected,
    "galleryId": galleryId,
    "galleryName": galleryName,
    "galleryType": galleryType,
    "id": id,
    "name": name,
  };
}
