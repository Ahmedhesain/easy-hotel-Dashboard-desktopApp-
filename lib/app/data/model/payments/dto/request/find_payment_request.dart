class FindPaymentRequest{
  final int branchId;
  final int? serial;
  final int? id;

  FindPaymentRequest({required this.branchId, this.serial, this.id});

  Map<String, dynamic> toJson(){
    return {
      "branchId": branchId,
      "serial": serial,
      "id": id,
    };
  }
}