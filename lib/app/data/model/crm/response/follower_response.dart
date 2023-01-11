
class FollowerResponse {
  FollowerResponse({
    this.type,
    this.id,
    this.index,
    this.email,
    this.mobile,
    this.name,
    this.nameEn,
    this.passportNumber,
    this.status,
  });

  String ?type;
  int ?id;
  int ?index;
  String? email;
  String ?mobile;
  String ?name;
  String ?nameEn;
  String ?passportNumber;
  int ?status;

  static List<FollowerResponse> fromList(dynamic json) => List<FollowerResponse>.from(json.map((e)=> FollowerResponse.fromJson(e)));


  factory FollowerResponse.fromJson(Map<String, dynamic> json) => FollowerResponse(
    type: json["type"] == null ? null : json["type"],
    id: json["id"] == null ? null : json["id"],
    index: json["index"] == null ? null : json["index"],
    email: json["email"] == null ? null : json["email"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    name: json["name"] == null ? null : json["name"],
    nameEn: json["nameEn"] == null ? null : json["nameEn"],
    passportNumber: json["passportNumber"] == null ? null : json["passportNumber"],
    status: json["status"] == null ? null : json["status"],
  );

}


