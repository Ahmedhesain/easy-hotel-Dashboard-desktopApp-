// To parse this JSON data, do
//
//     final bestSellingResponse = bestSellingResponseFromJson(jsonString);

import 'dart:convert';

class BestSellingResponse {
  BestSellingResponse({
    this.id,
    this.name,
    this.image,
    this.amount,
    this.count,
  });

  int? id;
  String? name;
  String? image;
  double? amount;
  dynamic count;

  static List<BestSellingResponse> fromList(dynamic json) => List.from(json.map((e)=> BestSellingResponse.fromJson(e)));


  factory BestSellingResponse.fromRawJson(String str) => BestSellingResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BestSellingResponse.fromJson( dynamic json) => BestSellingResponse(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    amount: json["amount"].toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "amount": amount,
    "count": count,
  };
}
