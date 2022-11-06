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
  int ?costAverage;
  GallaryFrom? gallaryFrom;
  List<dynamic>? gallarySelected;
  List<dynamic> ?groupDtoSelected;
  String ?name;
  double ?totallDiscount;
  double ?totallNet;
  int ?totallNumber;
  int ?totallSell;

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
