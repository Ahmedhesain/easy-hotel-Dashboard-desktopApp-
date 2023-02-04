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
    required this.gallaryId,
    required this.gallaryName,
  });

  final int? delegatorId;
  final DateTime? invDate;
  final int? invId;
  final int? gallaryId;
  final String? gallaryName;
  final int? invSerial;
  final String? iosCode;
  final int? iosId;
  final String? iosMobile;
  final String? iosName;

  factory FasehInvoiceResponse.fromJson(Map<String, dynamic> json) => FasehInvoiceResponse(
    delegatorId: json["delegatorId"],
    invDate: json["invDate"] == null ? null : DateTime.parse(json["invDate"]),
    invId: json["invId"],
    gallaryId: json["gallaryId"],
    gallaryName: json["gallaryName"],
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
    "gallaryId": gallaryId,
    "gallaryName": gallaryName,
    "invSerial": invSerial,
    "iosCode": iosCode,
    "iosId": iosId,
    "iosMobile": iosMobile,
    "iosName": iosName,
  };
}
