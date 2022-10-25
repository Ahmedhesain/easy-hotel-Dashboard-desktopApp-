import 'package:flutter/cupertino.dart';
import 'package:toby_bills/app/core/utils/app_storage.dart';
import 'package:toby_bills/app/data/model/item/dto/request/get_item_price_request.dart';
import 'package:toby_bills/app/data/model/item/dto/request/get_items_request.dart';
import 'package:toby_bills/app/data/model/item/dto/request/item_data_request.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_data_response.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_price_response.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/data/provider/api_provider.dart';

class ItemRepository {
  getAllItems(
    GetItemRequest getItemRequest, {
    Function()? onComplete,
    Function(List<ItemResponse> data)? onSuccess,
    Function(dynamic error)? onError,
  }) =>
      ApiProvider().post<List<ItemResponse>, List<dynamic>>(
        'items/findAllItemNew',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: getItemRequest.toJson(),
        onError: onError,
        convertor: ItemResponse.getList,
      );

  getAllItemsLocal({
    Function()? onComplete,
    Function(List<ItemResponse> data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    try {
      List<dynamic> items = AppStorage.read("items") ?? [];
      final itemsList = List<ItemResponse>.from(items.map((e) => ItemResponse.fromJson(e)));
      if (onSuccess != null) onSuccess(itemsList);
    } catch (e, s) {
      debugPrint("$e\n$s");
      if (onError != null) onError(e);
    }
    if (onComplete != null) {
      onComplete();
    }
  }

  getItemData(
    ItemDataRequest itemDataRequest, {
    Function()? onComplete,
    Function(ItemDataResponse data)? onSuccess,
    Function(dynamic error)? onError,
  }) =>
      ApiProvider().post<ItemDataResponse, Map<String, dynamic>>(
        'items/findItemData',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: itemDataRequest.toJson(),
        onError: onError,
        convertor: ItemDataResponse.fromJson,
      );

  getItemPrice(
    ItemPriceRequest itemPriceRequest, {
    Function()? onComplete,
    Function(ItemPriceResponse data)? onSuccess,
    Function(dynamic error)? onError,
  }) =>
      ApiProvider().post<ItemPriceResponse, Map<String, dynamic>>(
        'items/findItemPrice',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: itemPriceRequest.toJson(),
        onError: onError,
        convertor: ItemPriceResponse.fromJson,
      );
}
