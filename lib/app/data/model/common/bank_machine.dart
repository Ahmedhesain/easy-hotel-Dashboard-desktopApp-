


class BankMachineDTO {
  final int? id;
  final String? name;
  final int? serial;

  BankMachineDTO({this.id, this.name, this.serial});

  static List<BankMachineDTO> fromList(dynamic list) => List.from(list?.map((e) => BankMachineDTO.fromJson(e))?? []);
  factory BankMachineDTO.fromJson(Map<String , dynamic> json)=> BankMachineDTO(
    id: json["id"],
    name: json["name"],
    serial: json["serial"],
  );

  Map<String ,dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "serial" : serial,
  };

  @override
  String toString() {
    return name ?? "";
  }
}