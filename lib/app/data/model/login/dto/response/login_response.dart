// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.id,
     this.index,
     this.companyId,
    this.createdByName,
     this.branchId,
    this.deletedBy,
    this.igmaOwnerId,
    this.companyCode,
    this.branchSerial,
    this.igmaOwnerSerial,
    required this.userCode,
    required this.password,
    this.userName,
    required this.branchApplicationsDtoList,
    required this.name,
    this.lang,
    this.master,
    this.token,
    this.active,
    required this.adminUserName,
    required this.adminPassword,
    required this.taxValue,
    required this.dir,
    this.userDDs,
  });

  int id;
  int ?index;
  int ?companyId;
  dynamic createdByName;
  int ?branchId;
  dynamic deletedBy;
  dynamic igmaOwnerId;
  dynamic companyCode;
  dynamic branchSerial;
  dynamic igmaOwnerSerial;
  String ?userCode;
  String ?password;
  dynamic userName;
  List<BranchApplicationsDtoList>? branchApplicationsDtoList;
  String? name;
  dynamic lang;
  dynamic master;
  dynamic token;
  dynamic active;
  String adminUserName;
  String adminPassword;
  int taxValue;
  String dir;
  dynamic userDDs;

  factory LoginResponse.fromJson( dynamic json) => LoginResponse(
    id: json["id"],
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
    password: json["password"],
    userName: json["userName"],
    branchApplicationsDtoList: List<BranchApplicationsDtoList>.from(json["branchApplicationsDTOList"].map((x) => BranchApplicationsDtoList.fromJson(x))),
    name: json["name"],
    lang: json["lang"],
    master: json["master"],
    token: json["token"],
    active: json["active"],
    adminUserName: json["adminUserName"],
    adminPassword: json["adminPassword"],
    taxValue: json["taxValue"],
    dir: json["dir"],
    userDDs: json["userDDs"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
    "password": password,
    "userName": userName,
    "branchApplicationsDTOList": List<dynamic>.from(branchApplicationsDtoList!.map((x) => x.toJson())),
    "name": name,
    "lang": lang,
    "master": master,
    "token": token,
    "active": active,
    "adminUserName": adminUserName,
    "adminPassword": adminPassword,
    "taxValue": taxValue,
    "dir": dir,
    "userDDs": userDDs,
  };
}

class BranchApplicationsDtoList {
  BranchApplicationsDtoList({
    this.id,
    required this.markEdit,
    this.msg,
    this.msgType,
    this.markDisable,
    this.createdBy,
    this.createdDate,
    this.index,
    this.companyId,
    this.createdByName,
    required this.branchId,
    this.deletedBy,
    this.deletedDate,
    this.igmaOwnerId,
    this.companyCode,
    this.branchSerial,
    this.igmaOwnerSerial,
    this.userCode,
    required this.applications,
    required this.applicationName,
    this.imgOut,
    this.imgIn,
  });

  dynamic id;
  bool markEdit;
  dynamic msg;
  dynamic msgType;
  dynamic markDisable;
  dynamic createdBy;
  dynamic createdDate;
  dynamic index;
  dynamic companyId;
  dynamic createdByName;
  int branchId;
  dynamic deletedBy;
  dynamic deletedDate;
  dynamic igmaOwnerId;
  dynamic companyCode;
  dynamic branchSerial;
  dynamic igmaOwnerSerial;
  dynamic userCode;
  int applications;
  String applicationName;
  dynamic imgOut;
  dynamic imgIn;

  factory BranchApplicationsDtoList.fromJson(Map<String, dynamic> json) => BranchApplicationsDtoList(
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
    applications: json["applications"],
    applicationName: json["applicationName"],
    imgOut: json["imgOut"],
    imgIn: json["imgIn"],
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
    "applications": applications,
    "applicationName": applicationName,
    "imgOut": imgOut,
    "imgIn": imgIn,
  };
}
