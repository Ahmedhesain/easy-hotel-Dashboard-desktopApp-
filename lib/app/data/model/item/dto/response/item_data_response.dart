class ItemDataResponse {
  ItemDataResponse({
    required this.discountRow,
    required this.quantityOfUnit,
    required this.sellPrice,
    required this.unitName,
    required this.availableQuantity,
  });

  final num? availableQuantity;
  final num discountRow;
  final num quantityOfUnit;
  final num sellPrice;
  final String unitName;

  factory ItemDataResponse.fromJson(Map<String, dynamic> json) => ItemDataResponse(
    discountRow: json["discountRow"],
    quantityOfUnit: json["quantityOfUnit"],
    sellPrice: json["sellPrice"],
    unitName: json["unitName"],
    availableQuantity: json["availableQuantity"],
  );

  Map<String, dynamic> toJson() => {
    "discountRow": discountRow,
    "quantityOfUnit": quantityOfUnit,
    "sellPrice": sellPrice,
    "unitName": unitName,
    "availableQuantity": availableQuantity,
  };
}
