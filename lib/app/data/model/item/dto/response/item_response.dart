import 'package:toby_bills/app/data/model/item/dto/response/item_data_response.dart';

class ItemResponse {
  ItemResponse({
    required this.atrributesList,
    required this.branchId,
    required this.code,
    required this.companyId,
    required this.costAverage,
    // this.discountrate,
    required this.groupId,
    required this.id,
    required this.isInventoryItem,
    required this.itemType,
    required this.maxPriceMen,
    required this.maxPriceYoung,
    required this.minPriceMen,
    required this.minPriceYoung,
    required this.name,
    required this.numberMetersFreeMen,
    required this.numberMetersFreeYoung,
    required this.numberMetersMen,
    required this.numberMetersYoung,
    required this.price,
    required this.proGroupId,
    required this.remarks,
    required this.sellPrice,
    required this.supplierId,
    required this.unitId,
    required this.unitName,
    required this.variationsList,
    required this.typeShow,
    required this.lastCost,
  });

  List<dynamic>? atrributesList;
  int? branchId;
  String code;
  int? companyId;
  num? costAverage;
  // num ?discountrate;
  int? groupId;
  int id;
  int? isInventoryItem;
  int? itemType;
  num? maxPriceMen;
  num? maxPriceYoung;
  num? minPriceMen;
  num? minPriceYoung;
  String name;
  num? numberMetersFreeMen;
  num? numberMetersFreeYoung;
  num? numberMetersMen;
  num? numberMetersYoung;
  num? price;
  int? proGroupId;
  String? remarks;
  num? sellPrice;
  String? supplierId;
  int? unitId;
  String? unitName;
  int? typeShow;
  num? lastCost;
  List<dynamic>? variationsList;
  ItemDataResponse? itemData;

  num tempQuantity = 1;
  num tempNumber = 1;

  static List<ItemResponse> getList(List<dynamic> json) => List<ItemResponse>.from(json.map((e) => ItemResponse.fromJson(e)));

  factory ItemResponse.fromJson(Map<String, dynamic> json) => ItemResponse(
    atrributesList: json["atrributesList"] == null ? null : List<dynamic>.from(json["atrributesList"].map((x) => x)),
    branchId: json["branchId"],
    code: json["code"],
    companyId: json["companyId"],
    costAverage: json["costAverage"],
    // discountrate: json["discountrate"] == null ? null : json["discountrate"],
    groupId: json["groupId"],
    id: json["id"],
    isInventoryItem: json["isInventoryItem"],
    itemType: json["itemType"],
    maxPriceMen: json["maxPriceMen"].toDouble(),
    maxPriceYoung: json["maxPriceYoung"].toDouble(),
    minPriceMen: json["minPriceMen"].toDouble(),
    minPriceYoung: json["minPriceYoung"].toDouble(),
    name: json["name"],
    numberMetersFreeMen: json["numberMetersFreeMen"].toDouble(),
    numberMetersFreeYoung: json["numberMetersFreeYoung"].toDouble(),
    numberMetersMen: json["numberMetersMen"].toDouble(),
    numberMetersYoung: json["numberMetersYoung"].toDouble(),
    price: json["price"].toDouble(),
    proGroupId: json["proGroupId"],
    remarks: json["remarks"],
    sellPrice: json["sellPrice"].toDouble(),
    supplierId: json["supplierId"],
    unitId: json["unitId"],
    unitName: json["unitName"],
    typeShow: json["typeShow"],
    lastCost: json["lastCost"],
    variationsList: json["variationsList"] == null ? null : List<dynamic>.from(json["variationsList"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "atrributesList": atrributesList == null ? null : List<dynamic>.from(atrributesList!.map((x) => x)),
    "branchId": branchId,
    "code": code,
    "companyId": companyId,
    "costAverage": costAverage,
    // "discountrate": discountrate == null ? null : discountrate,
    "groupId": groupId,
    "id": id,
    "isInventoryItem": isInventoryItem,
    "itemType": itemType,
    "maxPriceMen":  maxPriceMen,
    "maxPriceYoung": maxPriceYoung,
    "minPriceMen": minPriceMen,
    "minPriceYoung": minPriceYoung,
    "name": name,
    "numberMetersFreeMen": numberMetersFreeMen,
    "numberMetersFreeYoung": numberMetersFreeYoung,
    "numberMetersMen": numberMetersMen,
    "numberMetersYoung": numberMetersYoung,
    "price": price,
    "proGroupId": proGroupId,
    "remarks": remarks,
    "sellPrice": sellPrice,
    "supplierId":supplierId,
    "unitId":unitId,
    "unitName": unitName,
    "typeShow": typeShow,
    "lastCost": lastCost,
    "variationsList": variationsList == null ? null : List<dynamic>.from(variationsList!.map((x) => x)),
  };
}
