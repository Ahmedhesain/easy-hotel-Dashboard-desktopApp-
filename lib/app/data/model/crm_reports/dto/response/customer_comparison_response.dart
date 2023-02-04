class CustomerComparisonResponse {
  final ClientPeriodDataDTO firstCustomer;
  final ClientPeriodDataDTO secondCustomer;

  CustomerComparisonResponse(
      {required this.firstCustomer, required this.secondCustomer});

  static List<CustomerComparisonResponse> fromList(dynamic json) =>
      List.from(json.map((e) => CustomerComparisonResponse.fromJson(e)));

  factory CustomerComparisonResponse.fromJson(Map<String, dynamic> json) =>
      CustomerComparisonResponse(
          firstCustomer: ClientPeriodDataDTO.fromJson(json["firstCustomer"]),
          secondCustomer: ClientPeriodDataDTO.fromJson(json["secondCustomer"]));
}

class ClientPeriodDataDTO {
  final int? totalInvoiceNumber;
  final num? totalThobeNumber;
  final double? totalInvoiceValue;

  ClientPeriodDataDTO(
      {this.totalInvoiceNumber, this.totalThobeNumber, this.totalInvoiceValue});

  factory ClientPeriodDataDTO.fromJson(Map<String, dynamic> json) =>
      ClientPeriodDataDTO(
        totalInvoiceNumber: json["totalInvoiceNumber"],
        totalThobeNumber: json["totalThobeNumber"],
        totalInvoiceValue: json["totalInvoiceValue"],
      );
}
