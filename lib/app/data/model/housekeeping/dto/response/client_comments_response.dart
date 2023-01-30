// To parse this JSON data, do
//
//     final clientCommentsResponse = clientCommentsResponseFromJson(jsonString);

import 'dart:convert';

class ClientCommentsResponse {
  ClientCommentsResponse({
    this.id,
    this.comment,
  });

  int? id;
  String? comment;
  static List<ClientCommentsResponse> fromList(dynamic json) => List.from(json.map((e)=> ClientCommentsResponse.fromJson(e)));

  factory ClientCommentsResponse.fromRawJson(String str) => ClientCommentsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClientCommentsResponse.fromJson(Map<String, dynamic> json) => ClientCommentsResponse(
    id: json["id"],
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
  };
}
