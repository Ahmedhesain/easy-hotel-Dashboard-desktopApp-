
class InvoiceStatusResponse {
  InvoiceStatusResponse({
    required this.clientName,
    required this.clientDate,
    required this.galaryDate,
    required this.deliveryDate,
    required this.factoryDate,
    required this.id,
    required this.idFactory,
    required this.inventoryName,
    required this.invoiceSerial,
    required this.numberToFactory,
    required this.numberTobExitFactory,
    required this.numberTobInvoice,
    required this.numberTobcustomer,
    required this.numberTobgallary,
    required this.parent,
    required this.parentCheck,
  });

  final String? clientName;
  final DateTime? clientDate;
  final DateTime? galaryDate;
  final DateTime? deliveryDate;
  final DateTime? factoryDate;
  final num? id;
  final num? idFactory;
  final String? inventoryName;
  final num? invoiceSerial;
  final num? numberToFactory;
  final num? numberTobExitFactory;
  final num? numberTobInvoice;
  final num? numberTobcustomer;
  final num? numberTobgallary;
  final num? parent;
  final String? parentCheck;

  static List<InvoiceStatusResponse> fromList(List<dynamic> json) => List<InvoiceStatusResponse>.from(json.map((e) => InvoiceStatusResponse.fromJson(e)));

  factory InvoiceStatusResponse.fromJson(Map<String, dynamic> json) => InvoiceStatusResponse(
    clientName: json["clientName"],
    deliveryDate: json["deliveryDate"] == null?null:DateTime.parse(json["deliveryDate"]),
    clientDate: json["clientDate"] == null?null:DateTime.parse(json["clientDate"]),
    galaryDate: json["galleryDate"] == null?null:DateTime.parse(json["galleryDate"]),
    factoryDate: json["factoryDate"] == null?null:DateTime.parse(json["factoryDate"]),
    id: json["id"],
    idFactory: json["idFactory"],
    inventoryName: json["inventoryName"],
    invoiceSerial: json["invoiceSerial"],
    numberToFactory: json["numberToFactory"],
    numberTobExitFactory: json["numberTobExitFactory"],
    numberTobInvoice: json["numberTobInvoice"],
    numberTobcustomer: json["numberTobcustomer"],
    numberTobgallary: json["numberTobgallary"],
    parent: json["parent"],
    parentCheck: json["parentCheck"],
  );

  Map<String, dynamic> toJson() => {
    "clientName": clientName,
    "deliveryDate": deliveryDate?.toIso8601String(),
    "factoryDate": factoryDate?.toIso8601String(),
    "id": id,
    "idFactory": idFactory,
    "inventoryName": inventoryName,
    "invoiceSerial": invoiceSerial,
    "numberToFactory": numberToFactory,
    "numberTobExitFactory": numberTobExitFactory,
    "numberTobInvoice": numberTobInvoice,
    "numberTobcustomer": numberTobcustomer,
    "numberTobgallary": numberTobgallary,
    "parent": parent,
    "parentCheck": parentCheck,
  };
}
