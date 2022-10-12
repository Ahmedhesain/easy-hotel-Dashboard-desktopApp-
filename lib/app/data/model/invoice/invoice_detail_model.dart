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
    this.remnants,
    this.unitName,
    this.progroupId,
    this.createdBy,
    this.createdDate,
    this.typeShow,
    this.lastCost,
    this.maxPriceMen,
    this.maxPriceYoung,
    this.minPriceMen,
    this.minPriceYoung,
    this.unitId,
    this.quantityOfOneUnit,
    this.netWithoutDiscount,
  }) : numberFocus = FocusNode(), quantityFocus = FocusNode(), priceFocus = FocusNode(), discountFocus = FocusNode(), discountValueFocus = FocusNode();

  FocusNode numberFocus;
  FocusNode quantityFocus;
  FocusNode priceFocus;
  FocusNode discountFocus;
  FocusNode discountValueFocus;

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
  int? remnants;
  int? progroupId;
  int? typeShow;
  num? lastCost;
  int? createdBy;
  DateTime? createdDate;

  bool isValidPrice(int priceType) {
    bool isValid = true;
    if(priceType == 1 && price! < minPriceMen!){
      price = minPriceMen;
      isValid = false;
    } else if(priceType == 1 && price! > maxPriceMen!){
      price = maxPriceMen;
      isValid = false;
    } else if(priceType == 0 && price! < minPriceYoung!){
      price = minPriceYoung;
      isValid = false;
    } else if(priceType == 0 && price! > maxPriceYoung!){
      price = maxPriceYoung;
      isValid = false;
    }
    return isValid;
  }


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
        discount: item.itemData!.discountRow,
        inventoryName: inventoryName,
        inventoryCode: inventoryCode,
        inventoryId: inventoryId,
        itemId: item.id,
        proof: proof,
        remnants: remnants,
        id: id,
        serial: serial,
        image: image,
        discountValue: discountValue,
        groupId: groupId,
        number: number,
        remark: remark,
        unitId: unitId,
        createdBy: createdBy,
        createdDate: createdDate,
        netWithoutDiscount: netWithoutDiscount,
        quantity: quantity);

    instance._calcData();
    return instance;
  }
  num get totalQuantity => ((number??0) * (quantity??0)).fixed(2);

  void _calcData() {
    netWithoutDiscount = (price! * totalQuantity).fixed(2);
    net = (netWithoutDiscount! - (netWithoutDiscount! * (discount! / 100)) - (discountValue??0)).fixed(2);
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
    int? remnants,
    String? unitName,
    int? progroupId,
    int? typeShow,
    int? createdBy,
    DateTime? createdDate,
    num? lastCost,
    num? maxPriceMen,
    num? maxPriceYoung,
    num? minPriceMen,
    num? minPriceYoung,
    int? unitId,
    num? quantityOfOneUnit,
    num? netWithoutDiscount,
  }) {
    final instance =  InvoiceDetailsModel(
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
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        price: price ?? this.price,
        itemId: itemId ?? this.itemId,
        groupId: groupId ?? this.groupId,
        availableQuantityRow: availableQuantityRow ?? this.availableQuantityRow,
        discount: discount ?? this.discount,
        discountValue: discountValue ?? this.discountValue,
        remnants: remnants ?? this.remnants,
        lastCost: lastCost ?? this.lastCost,
        maxPriceMen: maxPriceMen ?? this.maxPriceMen,
        maxPriceYoung: maxPriceYoung ?? this.maxPriceYoung,
        minPriceMen: minPriceMen ?? this.minPriceMen,
        minPriceYoung: minPriceYoung ?? this.minPriceYoung,
        number: number ?? this.number,
        progroupId: progroupId ?? this.progroupId,
        netWithoutDiscount: netWithoutDiscount ?? this.netWithoutDiscount,
        proof: proof ?? this.proof,
        quantityOfOneUnit: quantityOfOneUnit ?? this.quantityOfOneUnit,
        remark: remark ?? this.remark,
        typeShow: typeShow ?? this.typeShow,
        unitId: unitId ?? this.unitId,
        unitName: unitName ?? this.unitName,
      );
    instance._calcData();
    return instance;
  }

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
        createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
        createdBy: json["createdBy"],
        proof: json["proof"],
        quantity: json["quantity"],
        remnants: json["remnants"],
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
        "id": id,
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
        "remnants": remnants,
        "typeShow": typeShow,
        "progroupId": progroupId,
        "name": name,
        "unitName": unitName,
        "unitId": unitId,
        "maxPriceMen": maxPriceMen,
        "maxPriceYoung": maxPriceYoung,
        "minPriceMen": minPriceMen,
        "minPriceYoung": minPriceYoung,
        "createdDate": createdDate?.toIso8601String(),
        "createdBy": createdBy,
      };
}
