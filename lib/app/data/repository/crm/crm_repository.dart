


import 'package:toby_bills/app/data/model/common/request/symbol_request.dart';
import 'package:toby_bills/app/data/model/common/symbol_model_dto.dart';
import 'package:toby_bills/app/data/model/crm/request/crm_event_request.dart';
import 'package:toby_bills/app/data/model/crm/request/follower_request.dart';
import 'package:toby_bills/app/data/model/crm/response/follower_response.dart';

import '../../provider/api_provider.dart';

class CrmRepository{

       getEventTypes(
        SymbolRequest request, {
        Function()? onComplete,
        Function(List<SymbolDTO> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<SymbolDTO>,List<dynamic>>('symbol/eventType',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: SymbolDTO.fromList,
      );

       getPriorityList(
        SymbolRequest request, {
        Function()? onComplete,
        Function(List<SymbolDTO> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<SymbolDTO>,List<dynamic>>('symbol/crmPeriority',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: SymbolDTO.fromList,
      );

       getFollowers(
        FollowerRequest request, {
        Function()? onComplete,
        Function(List<FollowerResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<FollowerResponse>,List<dynamic>>('employee/findCRMEmployeeList',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: FollowerResponse.fromList,
      );

       addCrmEvent(
        CRMEventRequest request, {
        Function()? onComplete,
        Function(CRMEventRequest)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<CRMEventRequest,Map<String , dynamic>>("crmEvent/addCrm",
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: CRMEventRequest.fromJson,
      );


}