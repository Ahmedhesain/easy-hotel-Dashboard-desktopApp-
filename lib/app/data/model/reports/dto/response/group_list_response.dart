class GroupListResponse {
  const GroupListResponse({
    required this.name,
    required this.id,
  });

  final String? name;
  final int? id;

  static List<GroupListResponse> fromList(List<dynamic> json) => List.from(json.map((e) => GroupListResponse.fromJson(e)));

  factory GroupListResponse.fromJson(Map<String, dynamic> json) {
    return GroupListResponse(
        name: json["name"],
        id: json["id"]
    );
  }

}
