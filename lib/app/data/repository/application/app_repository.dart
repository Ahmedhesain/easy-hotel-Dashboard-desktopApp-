
import 'package:hotel_manger/app/data/model/housekeeping/dto/request/app_request_dto.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/housekeeping_groups_response.dart';
import 'package:hotel_manger/app/data/provider/api_provider.dart';

class HousekeepingRepository {

  getHousekeepingGroup(
      AppRequest request, {
        Function()? onComplete,
        SuccessFunc<List<HousekeepingGroupResponse>> onSuccess,
         Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<HousekeepingGroupResponse>>('houseKeeping/groupList',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: HousekeepingGroupResponse.fromList,
      );


}
