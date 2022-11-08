class CostCenterResponse {
  CostCenterResponse({
    this.type,
    this.branchId,
    this.createdBy,
    this.createdDate,
    this.id,
    this.index,
    this.code,
    this.name,
  });

  String? type;
  int? branchId;
  int? createdBy;
  DateTime? createdDate;
  int? id;
  int? index;
  int? code;
  String? name;

  static List<CostCenterResponse> fromList(List<dynamic> json) => List<CostCenterResponse>.from(json.map((e)=>CostCenterResponse.fromJson(e)));

  factory CostCenterResponse.fromJson(Map<String, dynamic> json) => CostCenterResponse(
    type: json["type"],
    branchId: json["branchId"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"] == null?null:DateTime.parse(json["createdDate"]),
    id: json["id"],
    index: json["index"],
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "branchId": branchId,
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "id": id,
    "index": index,
    "code": code,
    "name": name,
  };
}
