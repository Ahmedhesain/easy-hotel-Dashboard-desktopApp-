// To parse this JSON data, do
//
//     final itemDataRequest = itemDataRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ItemDataRequest itemDataRequestFromJson(String str) => ItemDataRequest.fromJson(json.decode(str));

String itemDataRequestToJson(ItemDataRequest data) => json.encode(data.toJson());

class ItemDataRequest {
  ItemDataRequest({
    this.id,
    this.customerId,
    this.priceType,
    this.inventoryId,
    this.invNameGallary,
  });

  int? id;
  int? customerId;
  int? priceType;
  int? inventoryId;
  int? invNameGallary;

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
