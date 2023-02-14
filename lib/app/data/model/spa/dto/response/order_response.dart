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
    this.offerId,
    this.price,
    this.discountValue,
    this.discountType,
    this.discountRate,
    this.salePrice,
    this.name,
    this.email,
    this.customerId,
    this.phone,
    this.address,
    this.finishName,
    this.finishBy,
    this.finishDate,
    this.dateClose,
    this.dueDate,
    this.dueTime,
    this.salesDetailSpaItemDtoList,
    this.addtionsDtoList,
    this.startDate,
    this.groupId,
    this.groupName
  });

  int? id;
  bool? markEdit;
  dynamic msg;
  dynamic msgType;
  dynamic markDisable;
  int? createdBy;
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
  int? offerId;
  double? price;
  double? discountValue;
  int? discountType;
  double? discountRate;
  double? salePrice;
  String? name;
  dynamic email;
  int? customerId;
  String? phone;
  dynamic address;
  dynamic finishName;
  dynamic finishBy;
  dynamic finishDate;
  dynamic dateClose;
  DateTime? dueDate;
  DateTime? dueTime;
  List<dynamic>? salesDetailSpaItemDtoList;
  List<dynamic>? addtionsDtoList;
  dynamic startDate;
  int ?groupId;
  String? groupName;
  static List<OrderResponse> fromList(dynamic json) => List.from(json.map((e) => OrderResponse.fromJson(e)));



  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
    id: json["id"],
    groupId: json["groupId"],
    groupName: json["groupName"],
    markEdit: json["markEdit"],
    msg: json["msg"],
    msgType: json["msgType"],
    markDisable: json["markDisable"],
    createdBy: json["createdBy"],
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
    offerId: json["offerId"],
    price: json["price"].toDouble(),
    discountValue: json["discountValue"].toDouble(),
    discountType: json["discountType"],
    discountRate: json["discountRate"].toDouble(),
    salePrice: json["salePrice"].toDouble(),
    name: json["name"],
    email: json["email"],
    customerId: json["customerId"],
    phone: json["phone"],
    address: json["address"],
    finishName: json["finishName"],
    finishBy: json["finishBy"],
    finishDate: json["finishDate"],
    dateClose: json["dateClose"],
    dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
    dueTime: json["dueTime"] == null ? null : DateTime.parse(json["dueTime"]),
    salesDetailSpaItemDtoList: json["salesDetailSpaItemDTOList"] == null ? [] : List<dynamic>.from(json["salesDetailSpaItemDTOList"]!.map((x) => x)),
    addtionsDtoList: json["addtionsDTOList"] == null ? [] : List<dynamic>.from(json["addtionsDTOList"]!.map((x) => x)),
    startDate: json["startDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "groupId": groupId,
    "groupName": groupName,
    "markEdit": markEdit,
    "msg": msg,
    "msgType": msgType,
    "markDisable": markDisable,
    "createdBy": createdBy,
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
    "offerId": offerId,
    "price": price,
    "discountValue": discountValue,
    "discountType": discountType,
    "discountRate": discountRate,
    "salePrice": salePrice,
    "name": name,
    "email": email,
    "customerId": customerId,
    "phone": phone,
    "address": address,
    "finishName": finishName,
    "finishBy": finishBy,
    "finishDate": finishDate,
    "dateClose": dateClose,
    "dueDate": dueDate!.toIso8601String(),
    "dueTime": dueTime!.toIso8601String(),
    "salesDetailSpaItemDTOList": salesDetailSpaItemDtoList == null ? [] : List<dynamic>.from(salesDetailSpaItemDtoList!.map((x) => x)),
    "addtionsDTOList": addtionsDtoList == null ? [] : List<dynamic>.from(addtionsDtoList!.map((x) => x)),
    "startDate": startDate,
  };
}
