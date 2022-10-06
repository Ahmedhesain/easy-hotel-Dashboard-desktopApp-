// To parse this JSON data, do
//
//     final itemDataRequest = itemDataRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ItemDataRequest itemDataRequestFromJson(String str) => ItemDataRequest.fromJson(json.decode(str));

String itemDataRequestToJson(ItemDataRequest data) => json.encode(data.toJson());

class ItemDataRequest {
  ItemDataRequest({
    required this.id,
    required this.customerId,
    required this.priceType,
    required this.inventoryId,
    required this.invNameGallary,
  });

  final int id;
  final int customerId;
  final int priceType;
  final int inventoryId;
  final int invNameGallary;

  factory ItemDataRequest.fromJson(Map<String, dynamic> json) => ItemDataRequest(
    id: json["id"],
    customerId: json["customerId"],
    priceType: json["priceType"],
    inventoryId: json["inventoryId"],
    invNameGallary: json["invNameGallary"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customerId": customerId,
    "priceType": priceType,
    "inventoryId": inventoryId,
    "invNameGallary": invNameGallary,
  };
}
