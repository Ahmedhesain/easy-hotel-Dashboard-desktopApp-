class ProductionStagesResponse {

  ProductionStagesResponse({
    this.client,
    this.clientName,
    this.clothNumber,
    this.date,
    this.empName,
    this.invInvoice,
    this.number,
    this.productName,
    this.quantity,
    this.stage,
  });

  String? client;
  String? clientName;
  int? clothNumber;
  DateTime? date;
  String? empName;
  int? invInvoice;
  num? number;
  String? productName;
  num? quantity;
  String? stage;

  static List<ProductionStagesResponse> fromList(List<dynamic> json) => List.from(json.map((e) => ProductionStagesResponse.fromJson(e)));

  ProductionStagesResponse.fromJson(Map<String, dynamic> json) {
    client = json['client'];
    clientName = json['clientName'];
    clothNumber = json['clothNumber'];
    date = DateTime.parse(json["date"]);
    empName = json['empName'];
    invInvoice = json['invInvoice'];
    number = json['number'];
    productName = json['productName'];
    quantity = json['quantity'];
    stage = json['stage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['client'] = client;
    data['clientName'] = clientName;
    data['clothNumber'] = clothNumber;
    data['date'] = date?.timeZoneOffset;
    data['empName'] = empName;
    data['invInvoice'] = invInvoice;
    data['number'] = number;
    data['productName'] = productName;
    data['quantity'] = quantity;
    data['stage'] = stage;
    return data;
  }
}
