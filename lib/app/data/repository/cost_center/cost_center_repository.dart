import 'package:flutter/cupertino.dart';
import 'package:toby_bills/app/core/utils/app_storage.dart';
import 'package:toby_bills/app/data/model/cost_center/dto/request/get_cost_center_request.dart';
import 'package:toby_bills/app/data/model/cost_center/dto/response/cost_center_response.dart';
import 'package:toby_bills/app/data/model/item/dto/request/get_item_price_request.dart';
import 'package:toby_bills/app/data/model/item/dto/request/get_items_request.dart';
import 'package:toby_bills/app/data/model/item/dto/request/item_data_request.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_data_response.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_price_response.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/data/provider/api_provider.dart';

class CostCenterRepository {

  getAll(
    GetCostCenterRequest getCostCenterRequest, {
    Function()? onComplete,
    Function(List<CostCenterResponse> data)? onSuccess,
    Function(dynamic error)? onError,
  }) =>
      ApiProvider().post<List<CostCenterResponse>, List<dynamic>>(
        'costcenter/costcenterlist',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: getCostCenterRequest.toJson(),
        onError: onError,
        convertor: CostCenterResponse.fromList,
      );

}
