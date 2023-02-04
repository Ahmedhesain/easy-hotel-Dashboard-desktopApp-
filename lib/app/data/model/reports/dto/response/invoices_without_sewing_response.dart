// To parse this JSON data, do
//
//     final companyInvoicesWithoutSewingResponse = companyInvoicesWithoutSewingResponseFromJson(jsonString);

import 'dart:convert';

CompanyInvoicesWithoutSewingResponse companyInvoicesWithoutSewingResponseFromJson(String str) => CompanyInvoicesWithoutSewingResponse.fromJson(json.decode(str));

String companyInvoicesWithoutSewingResponseToJson(CompanyInvoicesWithoutSewingResponse data) => json.encode(data.toJson());

class CompanyInvoicesWithoutSewingResponse {
  CompanyInvoicesWithoutSewingResponse({
    this.code,
    this.galleryName,
    this.id,
    this.name,
    this.total,
  });

  int ?code;
  String? galleryName;
  int ?id;
  String? name;
  double ?total;
  static List<CompanyInvoicesWithoutSewingResponse> fromList(List<dynamic> json) => List.from(json.map((e) => CompanyInvoicesWithoutSewingResponse.fromJson(e)));

  factory CompanyInvoicesWithoutSewingResponse.fromJson(Map<String, dynamic> json) => CompanyInvoicesWithoutSewingResponse(
    code: json["code"] == null ? null : json["code"],
    galleryName: json["galleryName"] == null ? null : json["galleryName"],
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    total: json["total"] == null ? null : json["total"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "galleryName": galleryName == null ? null : galleryName,
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "total": total == null ? null : total,
  };
}
