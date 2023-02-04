// To parse this JSON data, do
//
//     final clientsNoMovementResponse = clientsNoMovementResponseFromJson(jsonString);

import 'dart:convert';

ClientsNoMovementResponse clientsNoMovementResponseFromJson(String str) => ClientsNoMovementResponse.fromJson(json.decode(str));

String clientsNoMovementResponseToJson(ClientsNoMovementResponse data) => json.encode(data.toJson());

class ClientsNoMovementResponse {
  ClientsNoMovementResponse({
    this.clientName,
    this.clientNumber,
    this.lastInvoiceDate,
    this.phoneNumber,
    this.totalInvoices,
  });

  String? clientName;
  String ?clientNumber;
  DateTime? lastInvoiceDate;
  String ?phoneNumber;
  num ?totalInvoices;
  static List<ClientsNoMovementResponse> fromList(List<dynamic> json) => List.from(json.map((e) => ClientsNoMovementResponse.fromJson(e)));

  factory ClientsNoMovementResponse.fromJson(Map<String, dynamic> json) => ClientsNoMovementResponse(
    clientName: json["clientName"] == null ? null : json["clientName"],
    clientNumber: json["clientNumber"] == null ? null : json["clientNumber"],
    lastInvoiceDate: json["lastInvoiceDate"] == null ? null : DateTime.parse(json["lastInvoiceDate"]),
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
    totalInvoices: json["totalInvoices"] == null ? null : json["totalInvoices"],
  );

  Map<String, dynamic> toJson() => {
    "clientName": clientName == null ? null : clientName,
    "clientNumber": clientNumber == null ? null : clientNumber,
    "lastInvoiceDate": lastInvoiceDate == null ? null : lastInvoiceDate?.toIso8601String(),
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
    "totalInvoices": totalInvoices == null ? null : totalInvoices,
  };
}
