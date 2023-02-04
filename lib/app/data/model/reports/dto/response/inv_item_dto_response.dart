// To parse this JSON data, do
//
//     final invItemDtoResponse = invItemDtoResponseFromJson(jsonString);

import 'dart:convert';

InvItemDtoResponse invItemDtoResponseFromJson(String str) => InvItemDtoResponse.fromJson(json.decode(str));

String invItemDtoResponseToJson(InvItemDtoResponse data) => json.encode(data.toJson());

class InvItemDtoResponse {
  InvItemDtoResponse({
    this.type,
    this.id,
    this.markEdit,
    this.bounsepricemen,
    this.bounsepriceyoung,
    this.code,
    this.commissionrate,
    this.commissionvalue,
    this.discountrate,
    this.discountvalue,
    this.invBarcodeEntity,
    this.itemNatural,
    this.maxpricemen,
    this.maxpriceyoung,
    this.minpricemen,
    this.minpriceyoung,
    this.name,
    this.numbermetersfreemen,
    this.numbermetersfreeyoung,
    this.numbermetersmen,
    this.numbermetersyoung,
    this.quantity,
    this.sellPrice,
  });

  String? type;
  int ?id;
  bool ?markEdit;
  num ?bounsepricemen;
  num ?bounsepriceyoung;
  String? code;
  num? commissionrate;
  num ?commissionvalue;
  num ?discountrate;
  num ?discountvalue;
  List<dynamic>? invBarcodeEntity;
  num? itemNatural;
  num ?maxpricemen;
  num ?maxpriceyoung;
  num ?minpricemen;
  num ?minpriceyoung;
  String? name;
  double ?numbermetersfreemen;
  num? numbermetersfreeyoung;
  num? numbermetersmen;
  num? numbermetersyoung;
  num? quantity;
  double? sellPrice;

  static List<InvItemDtoResponse> fromList(List<dynamic> json) => List.from(json.map((e) => InvItemDtoResponse.fromJson(e)));


  factory InvItemDtoResponse.fromJson(Map<String, dynamic> json) => InvItemDtoResponse(
    type: json["type"] == null ? null : json["type"],
    id: json["id"] == null ? null : json["id"],
    markEdit: json["markEdit"] == null ? null : json["markEdit"],
    bounsepricemen: json["bounsepricemen"] == null ? null : json["bounsepricemen"],
    bounsepriceyoung: json["bounsepriceyoung"] == null ? null : json["bounsepriceyoung"],
    code: json["code"] == null ? null : json["code"],
    commissionrate: json["commissionrate"] == null ? null : json["commissionrate"],
    commissionvalue: json["commissionvalue"] == null ? null : json["commissionvalue"],
    discountrate: json["discountrate"] == null ? null : json["discountrate"],
    discountvalue: json["discountvalue"] == null ? null : json["discountvalue"],
    invBarcodeEntity: json["invBarcodeEntity"] == null ? null : List<dynamic>.from(json["invBarcodeEntity"].map((x) => x)),
    itemNatural: json["itemNatural"] == null ? null : json["itemNatural"],
    maxpricemen: json["maxpricemen"] == null ? null : json["maxpricemen"],
    maxpriceyoung: json["maxpriceyoung"] == null ? null : json["maxpriceyoung"],
    minpricemen: json["minpricemen"] == null ? null : json["minpricemen"],
    minpriceyoung: json["minpriceyoung"] == null ? null : json["minpriceyoung"],
    name: json["name"] == null ? null : json["name"],
    numbermetersfreemen: json["numbermetersfreemen"] == null ? null : json["numbermetersfreemen"].toDouble(),
    numbermetersfreeyoung: json["numbermetersfreeyoung"] == null ? null : json["numbermetersfreeyoung"],
    numbermetersmen: json["numbermetersmen"] == null ? null : json["numbermetersmen"],
    numbermetersyoung: json["numbermetersyoung"] == null ? null : json["numbermetersyoung"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    sellPrice: json["sellPrice"] == null ? null : json["sellPrice"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "id": id == null ? null : id,
    "markEdit": markEdit == null ? null : markEdit,
    "bounsepricemen": bounsepricemen == null ? null : bounsepricemen,
    "bounsepriceyoung": bounsepriceyoung == null ? null : bounsepriceyoung,
    "code": code == null ? null : code,
    "commissionrate": commissionrate == null ? null : commissionrate,
    "commissionvalue": commissionvalue == null ? null : commissionvalue,
    "discountrate": discountrate == null ? null : discountrate,
    "discountvalue": discountvalue == null ? null : discountvalue,
    "invBarcodeEntity": invBarcodeEntity == null ? null : List<dynamic>.from(invBarcodeEntity!.map((x) => x)),
    "itemNatural": itemNatural == null ? null : itemNatural,
    "maxpricemen": maxpricemen == null ? null : maxpricemen,
    "maxpriceyoung": maxpriceyoung == null ? null : maxpriceyoung,
    "minpricemen": minpricemen == null ? null : minpricemen,
    "minpriceyoung": minpriceyoung == null ? null : minpriceyoung,
    "name": name == null ? null : name,
    "numbermetersfreemen": numbermetersfreemen == null ? null : numbermetersfreemen,
    "numbermetersfreeyoung": numbermetersfreeyoung == null ? null : numbermetersfreeyoung,
    "numbermetersmen": numbermetersmen == null ? null : numbermetersmen,
    "numbermetersyoung": numbermetersyoung == null ? null : numbermetersyoung,
    "quantity": quantity == null ? null : quantity,
    "sellPrice": sellPrice == null ? null : sellPrice,
  };
}
