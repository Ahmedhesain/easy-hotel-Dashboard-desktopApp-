


class DailyAttachDetailImageDTO {
  final int? id ;
  final String? image;
  final int? dailyAttachDetailId;
  final int? createdBy;
  final DateTime? createdDate;


  DailyAttachDetailImageDTO({this.id, this.image, this.dailyAttachDetailId, this.createdBy , this.createdDate});

  static List<DailyAttachDetailImageDTO> fromList(dynamic json) => List.from(json.map((e) => DailyAttachDetailImageDTO.fromJson(e)));

  factory DailyAttachDetailImageDTO.fromJson(Map<String , dynamic> json) => DailyAttachDetailImageDTO(
      id : json["id"],
    image:json["image"],
    dailyAttachDetailId :json["dailyAttachDetailId"],
    createdBy :json["createdBy"],
    createdDate :json["createdDate"] != null? DateTime.tryParse(json["createdDate"]) : null,
  );


  Map<String , dynamic> toJson() => {
    "id" : id,
    "dailyAttachDetailId" : dailyAttachDetailId,
    "image" : image,
    "createdBy" : createdBy,
    "createdDate" : createdDate?.toIso8601String(),
  };
}