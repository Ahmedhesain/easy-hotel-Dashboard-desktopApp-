


import 'daily_attach_detail_image_dto.dart';

class DailyAttachDetailDTO {
  final int? id;
  final int? glBankId;
  final String? glBankName;
  final int? dailyAttachId;
  final List<DailyAttachDetailImageDTO>? dailyAttachDetailDetailDTOList;

  DailyAttachDetailDTO(
      {this.id,
      this.glBankId,
      this.glBankName,
      this.dailyAttachId,
      this.dailyAttachDetailDetailDTOList});


  static List<DailyAttachDetailDTO> fromList(dynamic json) => List.from(json.map((e) => DailyAttachDetailDTO.fromJson(e)));

  factory DailyAttachDetailDTO.fromJson(Map<String , dynamic> json) => DailyAttachDetailDTO(
      id : json["id"],
      glBankId:json["glBankId"],
      glBankName :json["glBankName"],
      dailyAttachId :json["dailyAttachId"],
      dailyAttachDetailDetailDTOList :DailyAttachDetailImageDTO.fromList(json["dailyAttachDetailDetailDTOList"] ?? []),
  );


  Map<String , dynamic> toJson() => {
    "id" : id,
    "glBankId" : glBankId,
    "glBankName" : glBankName,
    "dailyAttachId" : dailyAttachId,
    "dailyAttachDetailDetailDTOList" :List<dynamic>.from(dailyAttachDetailDetailDTOList?.map((e) => e.toJson()) ?? []) ,
  };
}



