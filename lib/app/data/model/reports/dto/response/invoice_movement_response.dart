// To parse this JSON data, do
//
//     final invoiceMovementResponse = invoiceMovementResponseFromJson(jsonString);

import 'dart:convert';

class InvoiceMovementResponse {
  InvoiceMovementResponse({
    this.clientName,
    this.deliveryDate,
    this.factoryDate,
    this.id,
    this.idFactory,
    this.inventoryName,
    this.invoiceSerial,
    this.numberToFactory,
    this.numberTobExitFactory,
    this.numberTobInvoice,
    this.numberTobcustomer,
    this.numberTobgallary,
    this.parent,
    this.parentCheck,
  });

  String ?clientName;
  DateTime? deliveryDate;
  DateTime? factoryDate;
  int ?id;
  int ?idFactory;
  String? inventoryName;
  num ?invoiceSerial;
  num ?numberToFactory;
  num ?numberTobExitFactory;
  num ?numberTobInvoice;
  num ?numberTobcustomer;
  num ?numberTobgallary;
  num ?parent;
  String ?parentCheck;

  static List<InvoiceMovementResponse> fromList(List<dynamic> json) => List.from(json.map((e) => InvoiceMovementResponse.fromJson(e)));

  factory InvoiceMovementResponse.fromRawJson(String str) => InvoiceMovementResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InvoiceMovementResponse.fromJson(Map<String, dynamic> json) => InvoiceMovementResponse(
    clientName: json["clientName"] == null ? null : json["clientName"],
    deliveryDate: json["deliveryDate"] == null ? null : DateTime.parse(json["deliveryDate"]),
    factoryDate: json["factoryDate"] == null ? null : DateTime.parse(json["factoryDate"]),
    id: json["id"] == null ? null : json["id"],
    idFactory: json["idFactory"] == null ? null : json["idFactory"],
    inventoryName: json["inventoryName"] == null ? null : json["inventoryName"],
    invoiceSerial: json["invoiceSerial"] == null ? null : json["invoiceSerial"],
    numberToFactory: json["numberToFactory"] == null ? null : json["numberToFactory"],
    numberTobExitFactory: json["numberTobExitFactory"] == null ? null : json["numberTobExitFactory"],
    numberTobInvoice: json["numberTobInvoice"] == null ? null : json["numberTobInvoice"],
    numberTobcustomer: json["numberTobcustomer"] == null ? null : json["numberTobcustomer"],
    numberTobgallary: json["numberTobgallary"] == null ? null : json["numberTobgallary"],
    parent: json["parent"] == null ? null : json["parent"],
    parentCheck: json["parentCheck"] == null ? null : json["parentCheck"],
  );

  Map<String, dynamic> toJson() => {
    "clientName": clientName == null ? null : clientName,
    "deliveryDate": deliveryDate == null ? null : deliveryDate?.toIso8601String(),
    "factoryDate": factoryDate == null ? null : factoryDate?.toIso8601String(),
    "id": id == null ? null : id,
    "idFactory": idFactory == null ? null : idFactory,
    "inventoryName": inventoryName == null ? null : inventoryName,
    "invoiceSerial": invoiceSerial == null ? null : invoiceSerial,
    "numberToFactory": numberToFactory == null ? null : numberToFactory,
    "numberTobExitFactory": numberTobExitFactory == null ? null : numberTobExitFactory,
    "numberTobInvoice": numberTobInvoice == null ? null : numberTobInvoice,
    "numberTobcustomer": numberTobcustomer == null ? null : numberTobcustomer,
    "numberTobgallary": numberTobgallary == null ? null : numberTobgallary,
    "parent": parent == null ? null : parent,
    "parentCheck": parentCheck == null ? null : parentCheck,
  };
}
