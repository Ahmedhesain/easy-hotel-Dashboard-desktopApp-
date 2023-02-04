import 'package:flutter/material.dart';
import 'package:toby_bills/app/core/extensions/num_extension.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';

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
    this.invNoticeValue,
    this.maxPriceMen,
    this.maxPriceYoung,
    this.minPriceMen,
    this.minPriceYoung,
    this.unitId,
    // this.glAccount,
    this.quantityOfOneUnit,
    this.numOfYarda,
    this.typeInv,
    this.netWithoutDiscount,
    this.account,
    this.accountName,
    this.isPurchaseInvoice = false,
  })  : numberFocus = FocusNode(),
        quantityFocus = FocusNode(),
        priceFocus = FocusNode(),
        discountFocus = FocusNode(),
        discountValueFocus = FocusNode();

  FocusNode numberFocus;
  FocusNode quantityFocus;
  FocusNode priceFocus;
  FocusNode discountFocus;
  FocusNode discountValueFocus;
  bool isPurchaseInvoice;
  num? numOfYarda = 0;
  int? typeInv;
  int? unitId;
  int? account;
  String? accountName;
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
  num? invNoticeValue;
  int? createdBy;
  DateTime? createdDate;

  bool isValidPrice(int priceType) {
    if (priceType == 1 && price! < minPriceMen!) {
      price = minPriceMen;
      return false;
    } else if (priceType == 0 && price! < minPriceYoung!) {
      price = minPriceYoung;
      return false;
    }
    return true;
  }

  InvoiceDetailsModel assignItem(ItemResponse item) {
    final instance = copyWith(
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
        price: item.itemData?.sellPrice ?? price,
        unitName: item.unitName,
        discount: item.itemData?.discountRow,
        itemId: item.id);

    instance.calcData();
    return instance;
  }

  num get totalQuantity => ((number ?? 1) * (quantityOfOneUnit ?? 1)).fixed(2);

  void calcData() {
    if (!isPurchaseInvoice) {
      netWithoutDiscount = (price! * (typeInv == 0 ? (quantity ?? 0) : (number ?? 0))).fixed(2);
    } else {
      netWithoutDiscount = (price! * (typeInv == 0 ? (quantityOfOneUnit ?? 0) : (number ?? 0))).fixed(2);
    }
    net = (netWithoutDiscount! - (netWithoutDiscount! * (discount! / 100)) - (discountValue ?? 0)).fixed(2);
  }

  InvoiceDetailsModel copyWith({
    String? name,
    String? code,
    int? serial,
    int? account,
    int? id,
    int? inventoryId,
    String? inventoryName,
    GlAccountResponse? glAccount,
    String? inventoryCode,
    num? quantity,
    num? numOfYarda,
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
    num? invNoticeValue,
    int? typeInv,
    bool? isPurchaseInvoice,
    String? accountName,
  }) {
    final instance = InvoiceDetailsModel(
      name: name ?? this.name,
      typeInv: typeInv ?? this.typeInv,
      isPurchaseInvoice: isPurchaseInvoice ?? this.isPurchaseInvoice,
      invNoticeValue: invNoticeValue ?? this.invNoticeValue,
      accountName: accountName ?? this.accountName,
      code: code ?? this.code,
      numOfYarda: numOfYarda ?? this.numOfYarda,
      account: account ?? this.account,
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
    instance.calcData();
    return instance;
  }

  factory InvoiceDetailsModel.fromJson(Map<String, dynamic> json) {
    final instance = InvoiceDetailsModel(
      id: json["id"],
      serial: json["serial"],
      typeInv: json["typeInv"],
      invNoticeValue: json["invNoticeValue"],
      availableQuantityRow: json["availableQuantityRow"],
      code: json["code"],
      discount: json["discount"] ?? 0,
      discountValue: json["discountValue"] ?? 0,
      groupId: json["groupId"],
      accountName: json["accountName"],
      remark: json["remark"],
      image: json["image"],
      inventoryId: json["inventoryId"],
      inventoryName: json["inventoryName"],
      inventoryCode: json["inventoryCode"],
      price: json["price"] ?? 0,
      createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
      createdBy: json["createdBy"],
      proof: json["proof"],
      quantity: json["quantity"] ?? 0,
      remnants: json["remnants"],
      itemId: json["itemId"],
      quantityOfOneUnit: json["quantityOfOneUnit"],
      number: json["number"] ?? 0,
      net: json["net"] ?? 0,
      name: json["name"],
      progroupId: json["progroupId"],
      typeShow: json["typeShow"],
      lastCost: json["lastCost"],
      unitName: json["unitName"],
      account: json["account"],
      unitId: json["unitId"],
      maxPriceMen: json["maxPriceMen"] ?? 0,
      maxPriceYoung: json["maxPriceYoung"] ?? 0,
      minPriceMen: json["minPriceMen"] ?? 0,
      minPriceYoung: json["minPriceYoung"] ?? 0,
    );
    // instance.calcData();
    return instance;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "typeInv": typeInv,
        "invNoticeValue": invNoticeValue,
        "serial": serial,
        "accountName": accountName,
        "account": account,
        "quantityOfOneUnit": quantityOfOneUnit,
        "quantity": totalQuantity,
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
