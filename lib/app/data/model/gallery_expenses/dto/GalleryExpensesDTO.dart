


class GalleryExpensesDTO {

  final String? remarks;

  final num? value;

  final int? id;

  final int? galleryId;

  final int? createdBy;
  final int? modifiedBy;
  final DateTime? createdDate;

  GalleryExpensesDTO(
      {this.remarks, this.value, this.galleryId, this.createdBy , this.id , this.modifiedBy , this.createdDate});


  static List<GalleryExpensesDTO> fromList(dynamic json) => List<GalleryExpensesDTO>.from(json.map((e) => GalleryExpensesDTO.fromJson(e)));


  factory GalleryExpensesDTO.fromJson(Map<String , dynamic> json) => GalleryExpensesDTO(
    id: json["id"],
    remarks: json["remarks"],
    value: json["value"],
    galleryId: json["galleryId"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"] != null ? DateTime.tryParse(json["createdDate"]) : null,
  );

  Map<String , dynamic> toJson() => {
    "id" : id ,
    "remarks" : remarks ,
    "value" : value ,
    "galleryId" : galleryId ,
    "createdBy" : createdBy ,
    "modifiedBy" : modifiedBy ,
    "createdDate" : createdDate?.toIso8601String() ,
  };

}