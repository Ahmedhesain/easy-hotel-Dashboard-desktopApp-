
class DelegatorResponse {
  DelegatorResponse({
    required this.type,
    required this.branchId,
    required this.companyId,
    required this.createdBy,
    required this.createdDate,
    required this.id,
    required this.index,
    required this.markEdit,
    required this.code,
    required this.gallaryDto,
    required this.mobile,
    required this.name,
  });

  final int type;
  final int branchId;
  final int companyId;
  final int createdBy;
  final DateTime createdDate;
  final int id;
  final int index;
  final bool markEdit;
  final String code;
  final GallaryDto gallaryDto;
  final String? mobile;
  final String name;

  static List<DelegatorResponse> getList(List<dynamic> json) => List<DelegatorResponse>.from(json.map((x) => DelegatorResponse.fromJson(x)));

  factory DelegatorResponse.fromJson(Map<String, dynamic> json) => DelegatorResponse(
    type: json["type"],
    branchId: json["branchId"],
    companyId: json["companyId"],
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    id: json["id"],
    index: json["index"],
    markEdit: json["markEdit"],
    code: json["code"],
    gallaryDto: GallaryDto.fromJson(json["gallaryDTO"]),
    mobile: json["mobile"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "branchId": branchId,
    "companyId": companyId,
    "createdBy": createdBy,
    "createdDate": createdDate.toIso8601String(),
    "id": id,
    "index": index,
    "markEdit": markEdit,
    "code": code,
    "gallaryDTO": gallaryDto.toJson(),
    "mobile": mobile,
    "name": name,
  };
}

class GallaryDto {
  GallaryDto({
    required this.id,
    required this.markEdit,
    required this.code,
    required this.name,
  });

  final int id;
  final bool markEdit;
  final String code;
  final String name;

  factory GallaryDto.fromJson(Map<String, dynamic> json) => GallaryDto(
    id: json["id"],
    markEdit: json["markEdit"],
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "markEdit": markEdit,
    "code": code,
    "name": name,
  };
}
