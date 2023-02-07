


class DailyAttachDetailImageDTO {
  final int? id ;
  final String? image;
  final int? dailyAttachDetailId;


  DailyAttachDetailImageDTO({this.id, this.image, this.dailyAttachDetailId});

  static List<DailyAttachDetailImageDTO> fromList(dynamic json) => List.from(json.map((e) => DailyAttachDetailImageDTO.fromJson(e)));

  factory DailyAttachDetailImageDTO.fromJson(Map<String , dynamic> json) => DailyAttachDetailImageDTO(
      id : json["id"],
    image:json["image"],
    dailyAttachDetailId :json["dailyAttachDetailId"],
  );


  Map<String , dynamic> toJson() => {
    "id" : id,
    "dailyAttachDetailId" : dailyAttachDetailId,
    "image" : image,
  };
}