class ProductionStagesRequest {
  ProductionStagesRequest({
    required this.serial,
    required this.branchId,
    required this.gallaryId,
  });

  final int serial;
  final int branchId;
  final int gallaryId;

  Map<String, dynamic> toJson(){
    return {
      "serial": serial,
      "branchId": branchId,
      "gallaryId": gallaryId
    };
  }

}
