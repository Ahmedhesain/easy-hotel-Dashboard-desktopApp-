


class GalleryExpensesDTO {

  final String? remarks;

  final num? value;

  final int? id;

  final int? galleryId;

  final int? createdBy;

  GalleryExpensesDTO(
      {this.remarks, this.value, this.galleryId, this.createdBy , this.id});


  static List<GalleryExpensesDTO> fromList(dynamic json) => List<GalleryExpensesDTO>.from(json.map((e) => GalleryExpensesDTO.fromJson(e)));


  factory GalleryExpensesDTO.fromJson(Map<String , dynamic> json) => GalleryExpensesDTO(
    id: json["id"],
    remarks: json["remarks"],
    value: json["value"],
    galleryId: json["galleryId"],
    createdBy: json["createdBy"],
  );

  Map<String , dynamic> toJson() => {
    "id" : id ,
    "remarks" : remarks ,
    "value" : value ,
    "galleryId" : galleryId ,
    "createdBy" : createdBy ,
  };

}