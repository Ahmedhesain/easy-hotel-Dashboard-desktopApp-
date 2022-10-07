class ItemPriceRequest {
  ItemPriceRequest({
    required this.id,
    required this.customerId,
    required this.priceType,
    required this.inventoryId,
    required this.quantityOfUnit,
    required this.invNameGallary,
  });

  final int id;
  final int customerId;
  final int priceType;
  final int inventoryId;
  final num quantityOfUnit;
  final int invNameGallary;


  Map<String, dynamic> toJson() => {
    "id": id,
    "customerId": customerId,
    "priceType": priceType,
    "inventoryId": inventoryId,
    "quantityOfUnit": quantityOfUnit,
    "invNameGallary": invNameGallary,
  };
}
