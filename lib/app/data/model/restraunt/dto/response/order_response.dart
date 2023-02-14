// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

class OrderResponse {
  OrderResponse({
    this.id,
    this.markEdit,
    this.msg,
    this.msgType,
    this.markDisable,
    this.createdBy,
    this.createdDate,
    this.index,
    this.companyId,
    this.createdByName,
    this.branchId,
    this.deletedBy,
    this.deletedDate,
    this.igmaOwnerId,
    this.companyCode,
    this.branchSerial,
    this.igmaOwnerSerial,
    this.userCode,
    this.spaId,
    this.spaItemId,
    this.spaItemName,
    this.spaItemImage,
    this.spaItemsDtoList,
    this.resOfferId,
    this.customerId,
    this.price,
    this.discountValue,
    this.discountType,
    this.discountRate,
    this.salePrice,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.finishName,
    this.finishBy,
    this.finishDate,
    this.reviewSpaDto,
  });

  int? id;
  bool? markEdit;
  dynamic msg;
  dynamic msgType;
  dynamic markDisable;
  int? createdBy;
  int? createdDate;
  int? index;
  int? companyId;
  dynamic createdByName;
  dynamic branchId;
  dynamic deletedBy;
  dynamic deletedDate;
  dynamic igmaOwnerId;
  dynamic companyCode;
  dynamic branchSerial;
  dynamic igmaOwnerSerial;
  dynamic userCode;
  int? spaId;
  int? spaItemId;
  dynamic spaItemName;
  dynamic spaItemImage;
  List<dynamic>? spaItemsDtoList;
  dynamic resOfferId;
  int? customerId;
  int? price;
  int? discountValue;
  int? discountType;
  int? discountRate;
  int? salePrice;
  String? name;
  String? email;
  String? phone;
  dynamic address;
  dynamic finishName;
  dynamic finishBy;
  dynamic finishDate;
  List<dynamic>? reviewSpaDto;
  static List<OrderResponse> fromList(dynamic json) => List.from(json.map((e)=> OrderResponse.fromJson(e)));

  factory OrderResponse.fromRawJson(String str) => OrderResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
    id: json["id"],
    markEdit: json["markEdit"],
    msg: json["msg"],
    msgType: json["msgType"],
    markDisable: json["markDisable"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"],
    index: json["index"],
    companyId: json["companyId"],
    createdByName: json["createdByName"],
    branchId: json["branchId"],
    deletedBy: json["deletedBy"],
    deletedDate: json["deletedDate"],
    igmaOwnerId: json["igmaOwnerId"],
    companyCode: json["companyCode"],
    branchSerial: json["branchSerial"],
    igmaOwnerSerial: json["igmaOwnerSerial"],
    userCode: json["userCode"],
    spaId: json["spaId"],
    spaItemId: json["spaItemId"],
    spaItemName: json["spaItemName"],
    spaItemImage: json["spaItemImage"],
    spaItemsDtoList: json["spaItemsDTOList"] == null ? [] : List<dynamic>.from(json["spaItemsDTOList"]!.map((x) => x)),
    resOfferId: json["resOfferId"],
    customerId: json["customerId"],
    price: json["price"],
    discountValue: json["discountValue"],
    discountType: json["discountType"],
    discountRate: json["discountRate"],
    salePrice: json["salePrice"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    finishName: json["finishName"],
    finishBy: json["finishBy"],
    finishDate: json["finishDate"],
    reviewSpaDto: json["reviewSpaDTO"] == null ? [] : List<dynamic>.from(json["reviewSpaDTO"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "markEdit": markEdit,
    "msg": msg,
    "msgType": msgType,
    "markDisable": markDisable,
    "createdBy": createdBy,
    "createdDate": createdDate,
    "index": index,
    "companyId": companyId,
    "createdByName": createdByName,
    "branchId": branchId,
    "deletedBy": deletedBy,
    "deletedDate": deletedDate,
    "igmaOwnerId": igmaOwnerId,
    "companyCode": companyCode,
    "branchSerial": branchSerial,
    "igmaOwnerSerial": igmaOwnerSerial,
    "userCode": userCode,
    "spaId": spaId,
    "spaItemId": spaItemId,
    "spaItemName": spaItemName,
    "spaItemImage": spaItemImage,
    "spaItemsDTOList": spaItemsDtoList == null ? [] : List<dynamic>.from(spaItemsDtoList!.map((x) => x)),
    "resOfferId": resOfferId,
    "customerId": customerId,
    "price": price,
    "discountValue": discountValue,
    "discountType": discountType,
    "discountRate": discountRate,
    "salePrice": salePrice,
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
    "finishName": finishName,
    "finishBy": finishBy,
    "finishDate": finishDate,
    "reviewSpaDTO": reviewSpaDto == null ? [] : List<dynamic>.from(reviewSpaDto!.map((x) => x)),
  };
}
