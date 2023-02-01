


import 'offer_detail_dto.dart';

class OfferDTO {
  final String? name;

  final String? describtion;
  final String? msg;

  final DateTime? dateFrom;

  final DateTime? dateTo;

  final int? id;
  final int? offerType;
  final int? active;

  final num? offerMin;

  final num? offerMax;

  final num? groupId;

  final num? offerValue;

  final num? sellPrice;

  final num? offerLimit;

  final List<OfferDetailDTO>? details ;

  final int? branchId;
  final int? companyId;
  final int? createdBy;


  OfferDTO(
      {this.name,
      this.describtion,
      this.dateFrom,
      this.dateTo,
      this.id,
      this.offerType,
      this.offerMin,
      this.offerMax,
      this.groupId,
      this.offerValue,
      this.sellPrice,
      this.offerLimit,
      this.details,
        this. branchId,
        this.companyId,
        this. createdBy,
        this. msg,
this.active
      });


  static List<OfferDTO> fromList(dynamic json) => List<OfferDTO>.from(json.map((e) => OfferDTO.fromJson(e)));

  factory OfferDTO.fromJson(Map<String, dynamic> json) => OfferDTO(
    id: json["id"],
    name: json["name"],
    msg: json["msg"],
    dateFrom: DateTime.tryParse(json["dateFrom"]),
    dateTo: DateTime.tryParse(json["dateTo"]),
    details: OfferDetailDTO.fromList(json["details"]),
    offerLimit: json["offerLimit"],
    offerMax: json["offerMax"],
    describtion: json["describtion"],
    offerType: json["offerType"],
    offerMin: json["offerMin"],
    offerValue: json["offerValue"],
    branchId: json["branchId"],
    createdBy: json["createdBy"],
    companyId: json["companyId"],
    active: json["active"],
    groupId: json["groupId"],
    sellPrice: json["sellPrice"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "dateFrom": dateFrom?.toIso8601String(),
    "dateTo": dateTo?.toIso8601String(),
    "details": List.from(details?.map((e) => e.toJson()) ?? []),
    "offerLimit":offerLimit,
    "offerMax": offerMax,
    "describtion":describtion,
    "offerType": offerType,
    "offerMin": offerMin,
    "offerValue": offerValue,
    "companyId": companyId,
    "branchId": branchId,
    "createdBy": createdBy,
    "active": active,
    "groupId": groupId,
    "sellPrice": sellPrice,
  };
}