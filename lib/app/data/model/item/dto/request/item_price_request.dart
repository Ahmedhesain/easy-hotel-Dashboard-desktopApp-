class ItemPriceRequest {
  ItemPriceRequest({
    this.id,
    this.customerId,
    this.priceType,
    this.inventoryId,
    this.quantityOfUnit,
    this.invNameGallary,
  });

  int? id;
  int? customerId;
  int? priceType;
  int? inventoryId;
  num? quantityOfUnit;
  int? invNameGallary;


  Map<String, dynamic> toJson() => {
    "id": id,
    "customerId": customerId,
    "priceType": priceType,
    "inventoryId": inventoryId,
    "quantityOfUnit": quantityOfUnit,
    "invNameGallary": invNameGallary,
  };
}
