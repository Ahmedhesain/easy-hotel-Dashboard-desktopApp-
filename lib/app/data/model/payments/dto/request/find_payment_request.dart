class FindPaymentRequest{
  final int branchId;
  final int? serial;

  FindPaymentRequest({required this.branchId,required this.serial});

  Map<String, dynamic> toJson(){
    return {
      "branchId": branchId,
      "serial": serial
    };
  }
}