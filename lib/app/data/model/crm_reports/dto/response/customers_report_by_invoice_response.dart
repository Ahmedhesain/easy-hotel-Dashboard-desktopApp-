


class CustomersReportByInvoiceResponse {
  final int? invoiceSerial;
  final DateTime? invoiceDate;
  final double? invoiceValue;
  final double? thobeNumber;
  final String? customerCode ;
  final String? customerName ;
  final String? customerMobile ;
  final int? customerId ;
  final String? InventoryCode ;
  final String? InventoryName ;

  CustomersReportByInvoiceResponse(
      {this.invoiceSerial,
      this.invoiceDate,
      this.invoiceValue,
      this.thobeNumber,
      this.customerCode,
      this.customerName,
      this.customerMobile,
      this.customerId,
      this.InventoryCode,
      this.InventoryName});

  static List<CustomersReportByInvoiceResponse> fromList(dynamic json) => List.from(json.map((e) => CustomersReportByInvoiceResponse.fromJson(e)));

  factory CustomersReportByInvoiceResponse.fromJson(Map<String , dynamic> json) => CustomersReportByInvoiceResponse(
    customerId: json["customerId"],
    invoiceSerial: json["invoiceSerial"],
    invoiceDate: json["invoiceDate"] != null ? DateTime.tryParse(json["invoiceDate"]) : null,
    invoiceValue: json["invoiceValue"],
    thobeNumber: json["thobeNumber"],
    customerCode: json["customerCode"],
    customerName: json["customerName"],
    customerMobile: json["customerMobile"],
    InventoryCode: json["InventoryCode"],
    InventoryName: json["InventoryName"],
  );
}