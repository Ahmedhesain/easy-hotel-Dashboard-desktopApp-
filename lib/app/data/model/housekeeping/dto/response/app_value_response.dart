import 'dart:ffi';

class AppValueResponse {
  AppValueResponse({
     this.value,
  });

  double? value;

  factory AppValueResponse.fromJson( dynamic json) => AppValueResponse(
    value: json["value"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
  };
}