class FindInvoiceDataRequest{

  FindInvoiceDataRequest({required this.invSerial,required this.branchId});

  final String? invSerial;
  final int? branchId;

  Map<String,dynamic> toJson(){
    return {
      "invSerial": invSerial,
      "branchId": branchId,
    };
  }

}