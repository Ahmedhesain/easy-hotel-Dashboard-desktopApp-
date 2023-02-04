

class SymbolDTO {
  String? type;
  int? id;
  int? index;
  int? serial;
  String? name;


  SymbolDTO({this.type,  this.id, this.index, this.serial, this.name});

  static List<SymbolDTO> fromList(dynamic json) => List<SymbolDTO>.from(json.map((e)=> SymbolDTO.fromJson(e)));

  factory SymbolDTO.fromJson(Map<String, dynamic> json) => SymbolDTO(
    type: json["type"] == null ? null : json["type"],
    id: json["id"] == null ? null : json["id"],
    index: json["index"] == null ? null : json["index"],
    serial: json["serial"] == null ? null : json["serial"],
    name: json["name"] == null ? null : json["name"],
  );

}