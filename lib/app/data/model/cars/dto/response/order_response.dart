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
    this.index,
    this.companyId,
    this.createdByName,
    this.branchId,
    this.deletedBy,
    this.igmaOwnerId,
    this.companyCode,
    this.branchSerial,
    this.igmaOwnerSerial,
    this.userCode,
    this.fromDestination,
    this.carId,
    this.personNumber,
    this.isGoingAndRetrun,
    this.dueDate,
    this.dueTime,
    this.leavingDate,
    this.leavingTime,
    this.comingTime,
    this.resOfferId,
    this.customerId,
    this.discountValue,
    this.discountType,
    this.discountRate,
    this.salePrice,
    this.salesDetailCarItemDtoList,
    this.addtionsDtoList,
    this.reviewCarDto,
    this.finishBy,
    this.finishName,
    this.startDate,
    this.finishDate,
    this.remark,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.dateClose,
    this.carName,
    this.groupId,
    this.groupName,
    this.customerName,
  });

  int? id;
  bool? markEdit;
  dynamic msg;
  dynamic msgType;
  dynamic markDisable;
  int? createdBy;
  int? index;
  int? companyId;
  dynamic createdByName;
  int? branchId;
  dynamic deletedBy;
  dynamic igmaOwnerId;
  dynamic companyCode;
  dynamic branchSerial;
  dynamic igmaOwnerSerial;
  dynamic userCode;
  int? fromDestination;
  dynamic carId;
  int? personNumber;
  int? isGoingAndRetrun;
  DateTime? dueDate;
  DateTime? dueTime;
  dynamic leavingDate;
  dynamic leavingTime;
  String? comingTime;
  dynamic resOfferId;
  int? customerId;
  int? discountValue;
  int? discountType;
  int? discountRate;
  double? salePrice;
  List<dynamic>? salesDetailCarItemDtoList;
  List<dynamic>? addtionsDtoList;
  Map<String, bool?>? reviewCarDto;
  dynamic finishBy;
  dynamic finishName;
  dynamic startDate;
  dynamic finishDate;
  String? remark;
  String? name;
  String? email;
  String? phone;
  dynamic address;
  dynamic dateClose;
  String? carName;
  int? groupId;
  String? groupName;
  String? customerName;



  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
    id: json["id"],
    markEdit: json["markEdit"],
    msg: json["msg"],
    msgType: json["msgType"],
    markDisable: json["markDisable"],
    createdBy: json["createdBy"],
    index: json["index"],
    companyId: json["companyId"],
    createdByName: json["createdByName"],
    branchId: json["branchId"],
    deletedBy: json["deletedBy"],
    igmaOwnerId: json["igmaOwnerId"],
    companyCode: json["companyCode"],
    branchSerial: json["branchSerial"],
    igmaOwnerSerial: json["igmaOwnerSerial"],
    userCode: json["userCode"],
    fromDestination: json["fromDestination"],
    carId: json["carId"],
    personNumber: json["personNumber"],
    isGoingAndRetrun: json["isGoingAndRetrun"],
    dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
    dueTime: json["dueTime"] == null ? null : DateTime.parse(json["dueTime"]),
    leavingDate: json["leavingDate"],
    leavingTime: json["leavingTime"],
    comingTime: json["comingTime"],
    resOfferId: json["resOfferId"],
    customerId: json["customerId"],
    discountValue: json["discountValue"],
    discountType: json["discountType"],
    discountRate: json["discountRate"],
    salePrice: json["salePrice"].toDouble(),
    salesDetailCarItemDtoList: json["salesDetailCarItemDTOList"] == null ? [] : List<dynamic>.from(json["salesDetailCarItemDTOList"]!.map((x) => x)),
    addtionsDtoList: json["addtionsDTOList"] == null ? [] : List<dynamic>.from(json["addtionsDTOList"]!.map((x) => x)),
    finishBy: json["finishBy"],
    finishName: json["finishName"],
    startDate: json["startDate"],
    finishDate: json["finishDate"],
    remark: json["remark"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    dateClose: json["dateClose"],

    carName: json["carName"],
    groupId: json["groupId"],
    groupName: json["groupName"],
    customerName: json["customerName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "markEdit": markEdit,
    "msg": msg,
    "msgType": msgType,
    "markDisable": markDisable,
    "createdBy": createdBy,
    "index": index,
    "companyId": companyId,
    "createdByName": createdByName,
    "branchId": branchId,
    "deletedBy": deletedBy,
    "igmaOwnerId": igmaOwnerId,
    "companyCode": companyCode,
    "branchSerial": branchSerial,
    "igmaOwnerSerial": igmaOwnerSerial,
    "userCode": userCode,
    "fromDestination": fromDestination,
    "carId": carId,
    "personNumber": personNumber,
    "isGoingAndRetrun": isGoingAndRetrun,
    "dueDate": dueDate!.toIso8601String(),
    "dueTime": dueTime!.toIso8601String(),
    "leavingDate": leavingDate,
    "leavingTime": leavingTime,
    "comingTime": comingTime,
    "resOfferId": resOfferId,
    "customerId": customerId,
    "discountValue": discountValue,
    "discountType": discountType,
    "discountRate": discountRate,
    "salePrice": salePrice,
    "salesDetailCarItemDTOList": salesDetailCarItemDtoList == null ? [] : List<dynamic>.from(salesDetailCarItemDtoList!.map((x) => x)),
    "addtionsDTOList": addtionsDtoList == null ? [] : List<dynamic>.from(addtionsDtoList!.map((x) => x)),
    "reviewCarDTO": Map.from(reviewCarDto!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "finishBy": finishBy,
    "finishName": finishName,
    "startDate": startDate,
    "finishDate": finishDate,
    "remark": remark,
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
    "dateClose": dateClose,
    "carName": carName,
    "groupId": groupId,
    "groupName": groupName,
    "customerName": customerName,
  };
}
