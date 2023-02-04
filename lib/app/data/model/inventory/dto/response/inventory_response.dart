// To parse this JSON data, do
//
//     final inventoryModel = inventoryModelFromJson(jsonString);

import 'dart:convert';

class InventoryResponse {
  InventoryResponse({
    required this.type,
    required this.id,
    required this.index,
    required this.markEdit,
    required this.code,
    required this.name,
    this.accountIdId,
    this.accountName,
    this.accountAccNumber,
  });

  final int? accountIdId;
  final String? accountName;
  final int? accountAccNumber;
  final String? type;
  final int? id;
  final int? index;
  final bool? markEdit;
  final String? code;
  final String? name;

  static List<InventoryResponse> getList(List<dynamic> json) => List<InventoryResponse>.from(json.map((e) => InventoryResponse.fromJson(e)));


  factory InventoryResponse.fromJson(Map<String, dynamic> json) => InventoryResponse(
    type: json["type"],
    id: json["id"],
    index: json["index"],
    markEdit: json["markEdit"],
    code: json["code"],
    name: json["name"],
    accountIdId: json["accountIdId"],
    accountName: json["accountName"],
    accountAccNumber: json["accountAccNumber"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "index": index,
    "markEdit": markEdit,
    "code": code,
    "name": name,
    "accountIdId": accountIdId,
    "accountName": accountName,
    "accountAccNumber": accountAccNumber,
  };
}