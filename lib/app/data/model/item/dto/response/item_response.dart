import 'package:toby_bills/app/data/model/item/dto/response/item_data_response.dart';

class ItemResponse {
  ItemResponse({
    this.atrributesList,
    this.branchId,
    this.code,
    this.companyId,
    this.costAverage,
    this.discountrate,
    this.discountValue,
    this.groupId,
    this.id,
    this.isInventoryItem,
    this.itemType,
    this.maxPriceMen,
    this.maxPriceYoung,
    this.minPriceMen,
    this.minPriceYoung,
    this.name,
    this.numberMetersFreeMen,
    this.numberMetersFreeYoung,
    this.numberMetersMen,
    this.numberMetersYoung,
    this.price,
    this.proGroupId,
    this.remarks,
    this.sellPrice,
    this.supplierId,
    this.unitId,
    this.unitName,
    this.variationsList,
    this.typeShow,
    this.lastCost,
    this.isRequiredEditPrivilege
  });

  List<dynamic>? atrributesList;
  int ?branchId;
  String? code;
  int ?companyId;
  num ?costAverage;
  num ?discountrate;
  num ?discountValue;
  int ?groupId;
  int ?id;
  int ?isInventoryItem;
  int ?itemType;
  num ?maxPriceMen;
  num ?maxPriceYoung;
  num ?minPriceMen;
  num ?minPriceYoung;
  String? name;
  num ?numberMetersFreeMen;
  num ?numberMetersFreeYoung;
  num? numberMetersMen;
  num? numberMetersYoung;
  num ?price;
  int ?proGroupId;
  String? remarks;
  num ?sellPrice;
  String? supplierId;
  int ?unitId;
  String? unitName;
  int? typeShow;
  num? lastCost;
  List<dynamic>? variationsList;
  ItemDataResponse? itemData;
  num tempQuantity = 1;
  num tempNumber = 1;
  num? isRequiredEditPrivilege;

  static List<ItemResponse> getList(List<dynamic> json) => List<ItemResponse>.from(json.map((e) => ItemResponse.fromJson(e)));

  factory ItemResponse.fromJson(Map<String, dynamic> json) => ItemResponse(
    atrributesList: json["atrributesList"] == null ? null : List<dynamic>.from(json["atrributesList"].map((x) => x)),
    branchId: json["branchId"],
    code: json["code"],
    companyId: json["companyId"],
    costAverage: json["costAverage"],
    discountrate: json["discountrate"],
    discountValue: json["discountValue"],
    groupId: json["groupId"],
    id: json["id"],
    isInventoryItem: json["isInventoryItem"],
    itemType: json["itemType"],
    maxPriceMen: json["maxPriceMen"],
    maxPriceYoung: json["maxPriceYoung"],
    minPriceMen: json["minPriceMen"],
    minPriceYoung: json["minPriceYoung"],
    name: json["name"],
    numberMetersFreeMen: json["numberMetersFreeMen"],
    numberMetersFreeYoung: json["numberMetersFreeYoung"],
    numberMetersMen: json["numberMetersMen"],
    numberMetersYoung: json["numberMetersYoung"],
    price: json["price"],
    proGroupId: json["proGroupId"],
    remarks: json["remarks"],
    sellPrice: json["sellPrice"],
    supplierId: json["supplierId"],
    unitId: json["unitId"],
    unitName: json["unitName"],
    typeShow: json["typeShow"],
    lastCost: json["lastCost"],
    isRequiredEditPrivilege: json["isRequiredEditPrivilege"] ?? 0,
    variationsList: json["variationsList"] == null ? null : List<dynamic>.from(json["variationsList"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "atrributesList": atrributesList == null ? null : List<dynamic>.from(atrributesList!.map((x) => x)),
    "branchId": branchId,
    "discountValue": discountValue,
    "code": code,
    "companyId": companyId,
    "costAverage": costAverage,
    "discountrate": discountrate,
    "groupId": groupId,
    "id": id,
    "isInventoryItem": isInventoryItem,
    "itemType": itemType,
    "maxPriceMen": maxPriceMen,
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
    "supplierId": supplierId,
    "unitId": unitId,
    "unitName": unitName,
    "typeShow": typeShow,
    "lastCost": lastCost,
    "variationsList": variationsList == null ? null : List<dynamic>.from(variationsList!.map((x) => x)),
  };

  @override
  String toString() => "$name $code";
}
