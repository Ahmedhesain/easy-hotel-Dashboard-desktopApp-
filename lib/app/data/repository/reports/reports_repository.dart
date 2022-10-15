import 'package:toby_bills/app/data/model/item/dto/request/get_item_price_request.dart';
import 'package:toby_bills/app/data/model/item/dto/request/get_items_request.dart';
import 'package:toby_bills/app/data/model/item/dto/request/item_data_request.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_data_response.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_price_response.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/categories_totals_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/group_list_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/categories_totals_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/group_list_response.dart';
import 'package:toby_bills/app/data/provider/api_provider.dart';

class ReportsRepository {


  getCategoriesTotals(
      CategoriesTotalsRequest categoriesTotalsRequest, {
        Function()? onComplete,
        Function(List<CategoriesTotalsResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<List<CategoriesTotalsResponse>,List<dynamic>>('salesReport/findSummition',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: categoriesTotalsRequest.toJson(),
        onError: onError,
        convertor: CategoriesTotalsResponse.fromList,
    );


  getGroupList(
      GroupListRequest groupListRequest, {
        Function()? onComplete,
        Function(List<GroupListResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<List<GroupListResponse>,List<dynamic>>('group/groupList',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: groupListRequest.toJson(),
        onError: onError,
        convertor: GroupListResponse.fromList,
    );

}
