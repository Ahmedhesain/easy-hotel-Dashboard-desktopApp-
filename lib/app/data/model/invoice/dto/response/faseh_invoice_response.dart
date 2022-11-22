class FasehInvoiceResponse {
  FasehInvoiceResponse({
    required this.delegatorId,
    required this.invDate,
    required this.invId,
    required this.invSerial,
    required this.iosCode,
    required this.iosId,
    required this.iosMobile,
    required this.iosName,
  });

  final int? delegatorId;
  final DateTime? invDate;
  final int? invId;
  final int? invSerial;
  final String? iosCode;
  final int? iosId;
  final String? iosMobile;
  final String? iosName;

  factory FasehInvoiceResponse.fromJson(Map<String, dynamic> json) => FasehInvoiceResponse(
    delegatorId: json["delegatorId"],
    invDate: json["invDate"] == null ? null : DateTime.parse(json["invDate"]),
    invId: json["invId"],
    invSerial: json["invSerial"],
    iosCode: json["iosCode"],
    iosId: json["iosId"],
    iosMobile: json["iosMobile"],
    iosName: json["iosName"],
  );

  Map<String, dynamic> toJson() => {
    "delegatorId": delegatorId,
    "invDate": invDate?.toIso8601String(),
    "invId": invId,
    "invSerial": invSerial,
    "iosCode": iosCode,
    "iosId": iosId,
    "iosMobile": iosMobile,
    "iosName": iosName,
  };
}
