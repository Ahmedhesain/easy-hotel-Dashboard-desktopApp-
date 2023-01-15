


class NotificationResponseDTO {
 final String? text ;
 final String? type ;
 dynamic id;

 NotificationResponseDTO({this.text, this.type , this.id});

 static List<NotificationResponseDTO> fromList(dynamic json) => List.from(json.map((e) => NotificationResponseDTO.fromJson(e)));
 factory NotificationResponseDTO.fromJson(Map<String , dynamic> json) => NotificationResponseDTO(
   type: json["type"] ,
   text: json["text"]
 );

 Map<String , dynamic> toJson() => {
   "text" : text ,
   "type" : type
 };
}