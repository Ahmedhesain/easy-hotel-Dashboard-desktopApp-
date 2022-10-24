class ItemsSalesRequest {
  ItemsSalesRequest({
    required this.inventoryId,
    required this.branchId,

  });

  final int inventoryId;
  final int branchId;


  Map<String, dynamic> toJson(){
    return {
      "serial": inventoryId,
      "branchId": branchId,

    };
  }

}
