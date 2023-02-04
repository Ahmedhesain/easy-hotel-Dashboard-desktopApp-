


class CompanyDTO {
  final String? name;
  final int? id ;
  final int? code;
  final int? branchId;
  final int? companyId;

  CompanyDTO({this.name, this.id,  this.code ,  this.branchId,  this.companyId,});


  static List<CompanyDTO> fromList(dynamic json) => List.from(json.map((e) => CompanyDTO.fromJson(e)));


  factory CompanyDTO.fromJson(Map<String , dynamic> json) => CompanyDTO(
    companyId: json['companyId'],
    id: json['id'],
    branchId: json['branchId'],
    code: json['code'],
    name: json['name'],
  );

  Map<String , dynamic> toJson() => {
    "name" : name,
    "id" : id,
    "code" : code,
    "branchId" : branchId,
    "companyId" : companyId,
  };

}