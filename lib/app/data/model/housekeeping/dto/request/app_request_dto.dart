class AllHousekeepingRequest {
  AllHousekeepingRequest({
    required this.appId,
  });

  int appId;

  factory AllHousekeepingRequest.fromJson(Map<String, dynamic> json) => AllHousekeepingRequest(
    appId: json["appId"],
  );

  Map<String, dynamic> toJson() => {
    "appId": appId,
  };
}