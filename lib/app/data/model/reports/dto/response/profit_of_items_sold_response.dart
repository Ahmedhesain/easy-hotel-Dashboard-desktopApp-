// To parse this JSON data, do
//
//     final profitOfItemsSoldResponse = profitOfItemsSoldResponseFromJson(jsonString);

import 'dart:convert';

List<ProfitOfItemsSoldResponse> profitOfItemsSoldResponseFromJson(String str) => List<ProfitOfItemsSoldResponse>.from(json.decode(str).map((x) => ProfitOfItemsSoldResponse.fromJson(x)));

String profitOfItemsSoldResponseToJson(List<ProfitOfItemsSoldResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfitOfItemsSoldResponse {
  ProfitOfItemsSoldResponse({
    this.code,
    this.costAverage,
    this.gallaryFrom,
    this.gallarySelected,
    this.groupDtoSelected,
    this.name,
    this.totallDiscount,
    this.totallNet,
    this.totallNumber,
    this.totallSell,
  });

  String? code;
  num ?costAverage;
  GallaryFrom? gallaryFrom;
  List<dynamic>? gallarySelected;
  List<dynamic> ?groupDtoSelected;
  String ?name;
  double ?totallDiscount;
  double ?totallNet;
  num ?totallNumber;
  num ?totallSell;

  static List<ProfitOfItemsSoldResponse> fromList(List<dynamic> json) => List.from(json.map((e) => ProfitOfItemsSoldResponse.fromJson(e)));


  factory ProfitOfItemsSoldResponse.fromJson(Map<String, dynamic> json) => ProfitOfItemsSoldResponse(
    code: json["code"] == null ? null : json["code"],
    costAverage: json["costAverage"] == null ? null : json["costAverage"],
    gallaryFrom: json["gallaryFrom"] == null ? null : GallaryFrom.fromJson(json["gallaryFrom"]),
    gallarySelected: json["gallarySelected"] == null ? null : List<dynamic>.from(json["gallarySelected"].map((x) => x)),
    groupDtoSelected: json["groupDTOSelected"] == null ? null : List<dynamic>.from(json["groupDTOSelected"].map((x) => x)),
    name: json["name"] == null ? null : json["name"],
    totallDiscount: json["totallDiscount"] == null ? null : json["totallDiscount"].toDouble(),
    totallNet: json["totallNet"] == null ? null : json["totallNet"].toDouble(),
    totallNumber: json["totallNumber"] == null ? null : json["totallNumber"],
    totallSell: json["totallSell"] == null ? null : json["totallSell"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "costAverage": costAverage == null ? null : costAverage,
    "gallaryFrom": gallaryFrom == null ? null : gallaryFrom?.toJson(),
    "gallarySelected": gallarySelected == null ? null : List<dynamic>.from(gallarySelected!.map((x) => x)),
    "groupDTOSelected": groupDtoSelected == null ? null : List<dynamic>.from(groupDtoSelected!.map((x) => x)),
    "name": name == null ? null : name,
    "totallDiscount": totallDiscount == null ? null : totallDiscount,
    "totallNet": totallNet == null ? null : totallNet,
    "totallNumber": totallNumber == null ? null : totallNumber,
    "totallSell": totallSell == null ? null : totallSell,
  };
}

class GallaryFrom {
  GallaryFrom({
    this.markEdit,
  });

  bool? markEdit;

  factory GallaryFrom.fromJson(Map<String, dynamic> json) => GallaryFrom(
    markEdit: json["markEdit"] == null ? null : json["markEdit"],
  );

  Map<String, dynamic> toJson() => {
    "markEdit": markEdit == null ? null : markEdit,
  };
}
// To parse this JSON data, do
//
//     final allGroupResponse = allGroupResponseFromJson(jsonString);


List<AllGroupResponse> allGroupResponseFromJson(String str) => List<AllGroupResponse>.from(json.decode(str).map((x) => AllGroupResponse.fromJson(x)));

String allGroupResponseToJson(List<AllGroupResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllGroupResponse {
  AllGroupResponse({
    this.type,
    this.branchId,
    this.companyId,
    this.createdBy,
    this.createdDate,
    this.id,
    this.index,
    this.markEdit,
    this.serial,
    this.name,
  });

  String? type;
  int ?branchId;
  int ?companyId;
  int ?createdBy;
  DateTime? createdDate;
  int ?id;
  int ?index;
  bool ?markEdit;
  int ?serial;
  String? name;
  static List<AllGroupResponse> fromList(List<dynamic> json) => List.from(json.map((e) => AllGroupResponse.fromJson(e)));


  factory AllGroupResponse.fromJson(Map<String, dynamic> json) => AllGroupResponse(
    type: json["type"] == null ? null : json["type"],
    branchId: json["branchId"] == null ? null : json["branchId"],
    companyId: json["companyId"] == null ? null : json["companyId"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    id: json["id"] == null ? null : json["id"],
    index: json["index"] == null ? null : json["index"],
    markEdit: json["markEdit"] == null ? null : json["markEdit"],
    serial: json["serial"] == null ? null : json["serial"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "branchId": branchId == null ? null : branchId,
    "companyId": companyId == null ? null : companyId,
    "createdBy": createdBy == null ? null : createdBy,
    "createdDate": createdDate == null ? null : createdDate?.toIso8601String(),
    "id": id == null ? null : id,
    "index": index == null ? null : index,
    "markEdit": markEdit == null ? null : markEdit,
    "serial": serial == null ? null : serial,
    "name": name == null ? null : name,
  };
}
