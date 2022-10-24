class QuantityItemsResponse {
  double? balance;
  int? id;
  String? itemName;

  QuantityItemsResponse({this.balance, this.id, this.itemName});
  static List<QuantityItemsResponse> fromList(List<dynamic> json) => List.from(json.map((e) => QuantityItemsResponse.fromJson(e)));

  QuantityItemsResponse.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    id = json['id'];
    itemName = json['itemName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['balance'] = balance;
    data['id'] = id;
    data['itemName'] = itemName;
    return data;
  }
}

