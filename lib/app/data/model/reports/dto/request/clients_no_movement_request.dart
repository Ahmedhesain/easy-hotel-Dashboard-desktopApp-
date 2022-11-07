// To parse this JSON data, do
//
//     final clientsNoMovementRequest = clientsNoMovementRequestFromJson(jsonString);

import 'dart:convert';

ClientsNoMovementRequest clientsNoMovementRequestFromJson(String str) => ClientsNoMovementRequest.fromJson(json.decode(str));

String clientsNoMovementRequestToJson(ClientsNoMovementRequest data) => json.encode(data.toJson());

class ClientsNoMovementRequest {
  ClientsNoMovementRequest({
    this.gallarySellected,
    this.branchId,
    this.dateFrom,
  });

  GallarySellected ?gallarySellected;
  int ?branchId;
  DateTime? dateFrom;

  factory ClientsNoMovementRequest.fromJson(Map<String, dynamic> json) => ClientsNoMovementRequest(
    gallarySellected: json["gallarySellected"] == null ? null : GallarySellected.fromJson(json["gallarySellected"]),
    branchId: json["branchId"] == null ? null : json["branchId"],
    dateFrom: json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
  );

  Map<String, dynamic> toJson() => {
    "gallarySellected": gallarySellected == null ? null : gallarySellected!.toJson(),
    "branchId": branchId == null ? null : branchId,
    "dateFrom": dateFrom == null ? null : dateFrom?.toIso8601String(),
  };
}

class GallarySellected {
  GallarySellected({
    this.id,
  });

  int ?id;

  factory GallarySellected.fromJson(Map<String, dynamic> json) => GallarySellected(
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
  };
}
