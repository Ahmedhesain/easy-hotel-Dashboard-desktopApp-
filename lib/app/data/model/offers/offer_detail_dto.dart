class OfferDetailDTO {
  final int? parentOfferId;

  final int? id;

  final int? itemId;

  final int? status;

  final int? addedOrExcluded;

  final int? branchId;
  final int? companyId;
  final int? createdBy;


  OfferDetailDTO({
    this.parentOfferId,
    this.itemId,
    this.status,
    this.addedOrExcluded,
    this.id,
    this.companyId,
    this.branchId,
    this.createdBy,
  });
  static List<OfferDetailDTO> fromList(dynamic json) => List<OfferDetailDTO>.from(json.map((e) => OfferDetailDTO.fromJson(e)));

  factory OfferDetailDTO.fromJson(Map<String, dynamic> json) => OfferDetailDTO(
        id: json["id"],
        parentOfferId: json["parentOfferId"],
        itemId: json["itemId"],
        addedOrExcluded: json["addedOrExcluded"],
        status: json["status"],
        companyId: json["companyId"],
        branchId: json["branchId"],
        createdBy: json["createdBy"],
      );

  Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "status": status,
        "addedOrExcluded": addedOrExcluded,
        "parentOfferId": parentOfferId,
        "id": id,
        "createdBy": createdBy,
        "branchId": branchId,
        "companyId": companyId,
      };
}
