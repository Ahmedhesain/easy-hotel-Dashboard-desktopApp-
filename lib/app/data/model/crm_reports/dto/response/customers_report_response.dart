


class CustomersReportResponse {
  final String clientName;
  final String clientCode;
  final String clientMobile;
  final int? black;

  CustomersReportResponse({required this.clientName, required this.clientCode, required this.clientMobile, this.black});

  static List<CustomersReportResponse> fromList(dynamic json) => List.from(json.map((e) => CustomersReportResponse.fromJson(e)));

  factory CustomersReportResponse.fromJson(Map<String , dynamic> json) => CustomersReportResponse(
      clientName: json["clientName"],
      clientCode: json["clientCode"],
      clientMobile: json["clientMobile"],
      black: json["black"]
  );
}