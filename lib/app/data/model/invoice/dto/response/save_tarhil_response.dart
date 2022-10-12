class SaveTarhilResponse {
  final int serial;
  final String qrCode;
  final String daribaValue;
  final String segilValue;

  SaveTarhilResponse({
    required this.serial,
    required this.qrCode,
    required this.daribaValue,
    required this.segilValue,
  });

  factory SaveTarhilResponse.fromJson(Map<String,dynamic> json){
    return SaveTarhilResponse(
      serial: json["serial"],
      qrCode: json["qrCode"],
      daribaValue: json["daribaValue"],
      segilValue: json["segilValue"],
    );
  }
}
