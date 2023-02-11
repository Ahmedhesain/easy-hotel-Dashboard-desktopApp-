

import 'daily_attach_detail_dto.dart';

class DailyAttachDTO {

   final int? id ;
   final int? gallaryId;
   final String? gallaryName;
   final DateTime? date;
   final List<DailyAttachDetailDTO>? dailyAttachDetailDTOList;
   final int? branchId ;
   final int? createdBy ;

   DailyAttachDTO(
      {this.id,
      this.gallaryId,
      this.gallaryName,
      this.date,
      this.dailyAttachDetailDTOList,this.branchId,this.createdBy});


   static List<DailyAttachDTO> fromList(dynamic json) => List.from(json.map((e) => DailyAttachDTO.fromJson(e)));

   factory DailyAttachDTO.fromJson(Map<String , dynamic> json) => DailyAttachDTO(
     id : json["id"],
     gallaryId:json["gallaryId"],
     gallaryName :json["gallaryName"],
     date :DateTime.tryParse(json["date"]),
     branchId :json["branchId"],
     createdBy :json["createdBy"],
     dailyAttachDetailDTOList : DailyAttachDetailDTO.fromList(json["dailyAttachDetailDTOList"] ?? [])

   );


   Map<String , dynamic> toJson() => {
     "id" : id,
     "gallaryId" : gallaryId,
     "gallaryName" : gallaryName,
     "date" : date?.toIso8601String(),
     "branchId" : branchId,
     "createdBy" : createdBy,
     "dailyAttachDetailDTOList" :List<dynamic>.from(dailyAttachDetailDTOList?.map((e) => e.toJson())?? []) ,
   };
}