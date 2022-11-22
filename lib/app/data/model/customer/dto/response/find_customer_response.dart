class FindCustomerResponse {
  FindCustomerResponse({
    required this.id,
    this.type,
    this.email,
    this.accountIdApi,
    this.code,
    this.discount,
    this.gallaryIdApi,
    this.length,
    this.mobile,
    this.name,
    this.offerCompanyName,
    this.shoulder,
    this.step,
    this.balanceLimit,
  });

  String? type;
  String? email;
  int? id;
  int? accountIdApi;
  String? code;
  num? discount;
  int? gallaryIdApi;
  num? length;
  String? mobile;
  String? name;
  String? offerCompanyName;
  num? shoulder;
  num? step;
  num? balanceLimit;

  factory FindCustomerResponse.fromJson(Map<String, dynamic> json) => FindCustomerResponse(
    type: json["type"],
    email: json["email"],
    id: json["id"],
    accountIdApi: json["accountIdAPI"],
    code: json["code"],
    discount: json["discount"],
    gallaryIdApi: json["gallaryIdAPI"],
    length: json["length"],
    mobile: json["mobile"],
    name: json["name"],
    offerCompanyName: json["offerCompanyName"],
    shoulder: json["shoulder"],
    step: json["step"],
    balanceLimit: json["balanceLimit"],
  );

  static List<FindCustomerResponse> getList(List<dynamic> json) => List<FindCustomerResponse>.from(json.map((e) => FindCustomerResponse.fromJson(e)));

  Map<String, dynamic> toJson() => {
    "type": type,
    "email": email,
    "id": id,
    "accountIdAPI": accountIdApi,
    "code": code,
    "discount": discount,
    "gallaryIdAPI": gallaryIdApi,
    "length": length,
    "mobile": mobile,
    "name": name,
    "offerCompanyName": offerCompanyName,
    "shoulder": shoulder,
    "step": step,
    "balanceLimit": balanceLimit,
  };


  @override
  String toString() {
    return name??"";
  }
}
