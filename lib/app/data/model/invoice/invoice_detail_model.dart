import 'package:flutter/material.dart';
import 'package:toby_bills/app/core/extensions/num_extension.dart';

import '../item/dto/response/item_response.dart';

class InvoiceDetailsModel {
  InvoiceDetailsModel({
    required this.name,
    this.code,
    this.serial,
    this.id,
    this.inventoryId,
    this.inventoryName,
    this.inventoryCode,
    this.quantity,
    this.remark,
    this.image,
    this.net,
    this.price,
    this.itemId,
    this.groupId,
    this.availableQuantityRow,
    this.discount,
    this.discountValue,
    this.number,
    this.proof,
    this.isRemains,
    this.unitName,
    this.progroupId,
    this.typeShow,
    this.lastCost,
    this.maxPriceMen,
    this.maxPriceYoung,
    this.minPriceMen,
    this.minPriceYoung,
    this.unitId,
    this.quantityOfOneUnit,
    this.netWithoutDiscount,
  }) : numberFocus = FocusNode(), quantityFocus = FocusNode(), priceFocus = FocusNode();

  FocusNode numberFocus;
  FocusNode quantityFocus;
  FocusNode priceFocus;

  int? unitId;
  String name;
  String? code;
  String? unitName;
  num? price;
  String? image;
  int? groupId;
  int? inventoryId;
  String? inventoryName;
  String? inventoryCode;
  String? remark;
  int? itemId;
  int? id;
  int? serial;
  num? net;
  num? netWithoutDiscount;
  num? quantity;
  num? number;
  num? maxPriceMen;
  num? maxPriceYoung;
  num? minPriceMen;
  num? minPriceYoung;
  num? quantityOfOneUnit;
  num? availableQuantityRow;
  num? discountValue;
  num? discount;
  int? proof;
  int? isRemains;
  int? progroupId;
  int? typeShow;
  num? lastCost;


  final numberFocusNode = FocusNode();
  final quantityFocusNode = FocusNode();
  final priceFocusNode = FocusNode();


  InvoiceDetailsModel assignItem(ItemResponse item) {
    final instance = InvoiceDetailsModel(
        progroupId: item.proGroupId,
        typeShow: item.typeShow,
        lastCost: item.lastCost,
        name: item.name,
        quantityOfOneUnit: item.itemData?.quantityOfUnit,
        code: item.code,
        minPriceMen: item.minPriceMen,
        minPriceYoung: item.minPriceYoung,
        maxPriceMen: item.maxPriceMen,
        maxPriceYoung: item.maxPriceYoung,
        availableQuantityRow: item.itemData?.availableQuantity,
        price: item.itemData?.sellPrice,
        unitName: item.unitName,
        discount: discount,
        inventoryName: inventoryName,
        inventoryCode: inventoryCode,
        inventoryId: inventoryId,
        itemId: item.id,
        proof: proof,
        isRemains: isRemains,
        id: id,
        serial: serial,
        image: image,
        discountValue: discountValue,
        groupId: groupId,
        number: number,
        remark: remark,
        unitId: unitId,
        netWithoutDiscount: netWithoutDiscount,
        quantity: unitId);

    instance._calcData(item);
    return instance;
  }

  void _calcData(ItemResponse item) {
    quantity = (item.itemData!.quantityOfUnit * number!).fixed(2);
    final net = ((item.itemData!.sellPrice) * number!).fixed(2);
    this.net = (net - (net * (item.itemData!.discountRow / 100)) - (discountValue??0)).fixed(2);
  }

  InvoiceDetailsModel copyWith({
    String? name,
    String? code,
    int? serial,
    int? id,
    int? inventoryId,
    String? inventoryName,
    String? inventoryCode,
    num? quantity,
    String? remark,
    String? image,
    num? net,
    num? price,
    int? itemId,
    int? groupId,
    num? availableQuantityRow,
    num? discount,
    num? discountValue,
    num? number,
    int? proof,
    int? isRemains,
    String? unitName,
    int? progroupId,
    int? typeShow,
    num? lastCost,
    num? maxPriceMen,
    num? maxPriceYoung,
    num? minPriceMen,
    num? minPriceYoung,
    int? unitId,
    num? quantityOfOneUnit,
  }) =>
      InvoiceDetailsModel(
        name: name ?? this.name,
        code: code ?? this.code,
        serial: serial ?? this.serial,
        id: id ?? this.id,
        inventoryId: inventoryId ?? this.inventoryId,
        inventoryName: inventoryName ?? this.inventoryName,
        inventoryCode: inventoryCode ?? this.inventoryCode,
        quantity: quantity ?? this.quantity,
        image: image ?? this.image,
        net: net ?? this.net,
        price: price ?? this.price,
        itemId: itemId ?? this.itemId,
        groupId: groupId ?? this.groupId,
        availableQuantityRow: availableQuantityRow ?? this.availableQuantityRow,
        discount: discount ?? this.discount,
        discountValue: discountValue ?? this.discountValue,
        isRemains: isRemains ?? this.isRemains,
        lastCost: lastCost ?? this.lastCost,
        maxPriceMen: maxPriceMen ?? this.maxPriceMen,
        maxPriceYoung: maxPriceYoung ?? this.maxPriceYoung,
        minPriceMen: minPriceMen ?? this.minPriceMen,
        minPriceYoung: minPriceYoung ?? this.minPriceYoung,
        number: number ?? this.number,
        progroupId: progroupId ?? this.progroupId,
        proof: proof ?? this.proof,
        quantityOfOneUnit: quantityOfOneUnit ?? this.quantityOfOneUnit,
        remark: remark ?? this.remark,
        typeShow: typeShow ?? this.typeShow,
        unitId: unitId ?? this.unitId,
        unitName: unitName ?? this.unitName,
      );

  factory InvoiceDetailsModel.fromJson(Map<String, dynamic> json) => InvoiceDetailsModel(
        id: json["id"],
        serial: json["serial"],
        availableQuantityRow: json["availableQuantityRow"],
        code: json["code"],
        discount: json["discount"],
        discountValue: json["discountValue"],
        groupId: json["groupId"],
        remark: json["remark"],
        image: json["image"],
        inventoryId: json["inventoryId"],
        inventoryName: json["inventoryName"],
        inventoryCode: json["inventoryCode"],
        price: json["price"],
        proof: json["proof"],
        quantity: json["quantity"],
        isRemains: json["isRemains"],
        itemId: json["itemId"],
        quantityOfOneUnit: json["quantityOfOneUnit"],
        number: json["number"],
        net: json["net"],
        name: json["name"],
        progroupId: json["progroupId"],
        typeShow: json["typeShow"],
        lastCost: json["lastCost"],
        unitName: json["unitName"],
        unitId: json["unitId"],
        maxPriceMen: json["maxPriceMen"],
        maxPriceYoung: json["unitId"],
        minPriceMen: json["unitId"],
        minPriceYoung: json["unitId"],
      );

  Map<String, dynamic> toJson() => {
        "serial": serial,
        "quantityOfOneUnit": quantityOfOneUnit,
        "quantity": quantity,
        "proof": proof,
        "discountValue": discountValue,
        "groupId": groupId,
        "itemId": itemId,
        "net": net,
        "inventoryName": inventoryName,
        "inventoryCode": inventoryCode,
        "discount": discount,
        "code": code,
        "number": number,
        "availableQuantityRow": availableQuantityRow,
        "price": price,
        "inventoryId": inventoryId,
        "image": image,
        "lastCost": lastCost,
        "isRemains": isRemains,
        "typeShow": typeShow,
        "progroupId": progroupId,
        "name": name,
        "unitName": unitName,
        "unitId": unitId,
        "maxPriceMen": maxPriceMen,
        "maxPriceYoung": maxPriceYoung,
        "minPriceMen": minPriceMen,
        "minPriceYoung": minPriceYoung,
      };
}
