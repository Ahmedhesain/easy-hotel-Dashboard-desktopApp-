class AppResponse {
  AppResponse({
    required this.number,
  });

  int number;

  factory AppResponse.fromJson(Map<String, dynamic> json) => AppResponse(
    number: json["branchId"],
  );

  Map<String, dynamic> toJson() => {
    "branchId": number,
  };
}