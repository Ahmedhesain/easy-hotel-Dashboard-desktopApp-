class ItemPriceResponse {
  ItemPriceResponse({
    required this.sellPrice,
  });

  final num sellPrice;

  factory ItemPriceResponse.fromJson(Map<String, dynamic> json) => ItemPriceResponse(
    sellPrice: json["sellPrice"],
  );

}
