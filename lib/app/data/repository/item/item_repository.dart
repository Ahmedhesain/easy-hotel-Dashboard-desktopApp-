import 'package:toby_bills/app/data/model/invoice/dto/request/get_delivery_place_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_due_date_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_invoice_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delegator_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_due_date_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_invoice_reponse.dart';
import 'package:toby_bills/app/data/model/item/dto/request/get_items_request.dart';
import 'package:toby_bills/app/data/model/item/dto/request/item_data_request.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_data_response.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/data/provider/api_provider.dart';
import '../../model/customer/dto/request/find_customer_request.dart';
import '../../model/customer/dto/response/find_customer_response.dart';
import '../../model/invoice/dto/request/get_delegator_request.dart';
import '../../model/invoice/dto/response/get_delivery_place_response.dart';

class ItemRepository {


  getAllItems(
      GetItemRequest getItemRequest, {
        Function()? onComplete,
        Function(List<ItemResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<List<ItemResponse>,List<dynamic>>('items/findAllItemNew',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: getItemRequest.toJson(),
        onError: onError,
        convertor: ItemResponse.getList,
    );

  getItemData(
      ItemDataRequest itemDataRequest, {
        Function()? onComplete,
        Function(ItemDataResponse data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<ItemDataResponse,Map<String,dynamic>>('items/findItemData',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: itemDataRequest.toJson(),
        onError: onError,
        convertor: ItemDataResponse.fromJson,
    );


}
