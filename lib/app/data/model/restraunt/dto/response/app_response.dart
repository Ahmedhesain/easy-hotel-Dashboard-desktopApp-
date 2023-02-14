class AppResponse {
  AppResponse({
    required this.number,
  });

  int number;

  factory AppResponse.fromJson( dynamic json) => AppResponse(
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
  };
}