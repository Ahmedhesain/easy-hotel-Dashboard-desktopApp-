


class NotificationResponseDTO {
 final String? text ;
 final String? type ;

 NotificationResponseDTO({this.text, this.type});

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