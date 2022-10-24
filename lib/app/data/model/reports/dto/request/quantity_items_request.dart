class QuantityItemsRequest {
  QuantityItemsRequest({
    required this.inventoryId,
    required this.branchId,

  });

  final int inventoryId;
  final int branchId;


  Map<String, dynamic> toJson(){
    return {
      "inventoryId": inventoryId,
      "branchId": branchId,

    };
  }

}
