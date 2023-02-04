import 'dart:convert';


class PurchaseBySupplierGroup{

  PurchaseBySupplierGroup({required this.name,required this.purchases});

  final String name;
  final List<PurchaseBySupplier> purchases;

}
class PurchaseBySupplier {
  PurchaseBySupplier({
    required this.cost,
    required this.costAvarage,
    required this.costAvarageFashTotal,
    required this.costAvarageTotal,
    required this.date,
    required this.detailItemQuantity,
    required this.discount,
    required this.fash,
    required this.itemBarcode,
    required this.itemCode,
    required this.itemId,
    required this.itemName,
    required this.itemQuantity,
    required this.itemUnitName,
    required this.net,
    required this.number,
    required this.organizationSiteCode,
    required this.organizationSiteId,
    required this.organizationSiteName,
    required this.paymentType,
    required this.quantityOfOne,
    required this.serial,
    required this.serialTax,
  });

  double? cost;
  int? costAvarage;
  int? costAvarageFashTotal;
  double? costAvarageTotal;
  DateTime? date;
  double? detailItemQuantity;
  double? discount;
  int? fash;
  String? itemBarcode;
  String? itemCode;
  int? itemId;
  String? itemName;
  double? itemQuantity;
  String? itemUnitName;
  double? net;
  int? number;
  String? organizationSiteCode;
  int? organizationSiteId;
  String? organizationSiteName;
  int? paymentType;
  double? quantityOfOne;
  int? serial;
  int? serialTax;


  static List<PurchaseBySupplier> fromList(List<dynamic> json) => List.from(json.map((e) => PurchaseBySupplier.fromJson(e)));


  factory PurchaseBySupplier.fromJson(Map<String, dynamic> json) => PurchaseBySupplier(
    cost: json["cost"]?.toDouble(),
    costAvarage: json["costAvarage"],
    costAvarageFashTotal: json["costAvarageFashTotal"],
    costAvarageTotal: json["costAvarageTotal"]?.toDouble(),
    date: DateTime.parse(json["date"]),
    detailItemQuantity: json["detailItemQuantity"]?.toDouble(),
    discount: json["discount"]?.toDouble(),
    fash: json["fash"],
    itemBarcode: json["itemBarcode"],
    itemCode: json["itemCode"],
    itemId: json["itemId"],
    itemName: json["itemName"],
    itemQuantity: json["itemQuantity"]?.toDouble(),
    itemUnitName: json["itemUnitName"],
    net: json["net"]?.toDouble(),
    number: json["number"],
    organizationSiteCode: json["organizationSiteCode"],
    organizationSiteId: json["organizationSiteId"],
    organizationSiteName: json["organizationSiteName"],
    paymentType: json["paymentType"],
    quantityOfOne: json["quantityOfOne"]?.toDouble(),
    serial: json["serial"],
    serialTax: json["serialTax"],
  );

  Map<String, dynamic> toJson() => {
    "cost": cost,
    "costAvarage": costAvarage,
    "costAvarageFashTotal": costAvarageFashTotal,
    "costAvarageTotal": costAvarageTotal,
    "date": date?.toIso8601String(),
    "detailItemQuantity": detailItemQuantity,
    "discount": discount,
    "fash": fash,
    "itemBarcode": itemBarcode,
    "itemCode": itemCode,
    "itemId": itemId,
    "itemName": itemName,
    "itemQuantity": itemQuantity,
    "itemUnitName": itemUnitName,
    "net": net,
    "number": number,
    "organizationSiteCode": organizationSiteCode,
    "organizationSiteId": organizationSiteId,
    "organizationSiteName": organizationSiteName,
    "paymentType": paymentType,
    "quantityOfOne": quantityOfOne,
    "serial": serial,
    "serialTax": serialTax,
  };
}
