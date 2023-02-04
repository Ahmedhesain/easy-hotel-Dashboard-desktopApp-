class FindFasehInvoiceRequest{

  FindFasehInvoiceRequest({required this.invSerial});

  final String invSerial;

  Map<String, dynamic> toJson(){
    return {
      "invSerial": invSerial
    };
  }
}
