class AppRequest {
  AppRequest({
    required this.branchId,
  });

  int branchId;

  factory AppRequest.fromJson(Map<String, dynamic> json) => AppRequest(
    branchId: json["branchId"],
  );

  Map<String, dynamic> toJson() => {
    "branchId": branchId,
  };
}