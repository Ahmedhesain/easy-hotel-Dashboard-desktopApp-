import 'package:toby_bills/app/data/model/inventory/dto/request/get_inventories_request.dart';
import 'package:toby_bills/app/data/model/inventory/dto/response/inventory_response.dart';
import 'package:toby_bills/app/data/provider/api_provider.dart';

class InventoryRepository {

  getAllInventories(
      GetInventoriesRequest getInventoriesRequest, {
        Function()? onComplete,
        Function(List<InventoryResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<List<InventoryResponse>,List<dynamic>>('inventory/findAllInventroisByUser',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: getInventoriesRequest.toJson(),
        onError: onError,
        convertor: InventoryResponse.getList,
    );


}
