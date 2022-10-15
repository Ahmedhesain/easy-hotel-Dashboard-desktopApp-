import 'dart:convert';

class CategoriesTotalsResponse {
  CategoriesTotalsResponse({
    this.allAvarageCost,
    this.allCost,
    this.allQuantity,
    this.code,
    this.customerNumber,
    this.deliveryNumber,
    this.different,
    this.factoryNumber,
    this.name,
    this.number,
    this.quantity,
    this.rowType,
    this.sendNumber,
  });

  double? allAvarageCost;
  double? allCost;
  num? allQuantity;
  num? code;
  num? customerNumber;
  num? deliveryNumber;
  num? different;
  num? factoryNumber;
  String? name;
  num? number;
  num? quantity;
  num? rowType;
  num? sendNumber;

  static List<CategoriesTotalsResponse> fromList(List<dynamic> json) => List<CategoriesTotalsResponse>.from(json.map((x) => CategoriesTotalsResponse.fromJson(x)));

  factory CategoriesTotalsResponse.fromJson(Map<String, dynamic> json) => CategoriesTotalsResponse(
    allAvarageCost: json["allAvarageCost"].toDouble(),
    allCost: json["allCost"].toDouble(),
    allQuantity: json["allQuantity"],
    code: json["code"],
    customerNumber: json["customerNumber"],
    deliveryNumber: json["deliveryNumber"],
    different: json["different"],
    factoryNumber: json["factoryNumber"],
    name: json["name"],
    number: json["number"],
    quantity: json["quantity"],
    rowType: json["rowType"],
    sendNumber: json["sendNumber"],
  );

  Map<String, dynamic> toJson() => {
    "allAvarageCost": allAvarageCost,
    "allCost": allCost,
    "allQuantity": allQuantity,
    "code": code,
    "customerNumber": customerNumber,
    "deliveryNumber": deliveryNumber,
    "different": different,
    "factoryNumber": factoryNumber,
    "name": name,
    "number": number,
    "quantity": quantity,
    "rowType": rowType,
    "sendNumber": sendNumber,
  };
}
