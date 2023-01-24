


import '../../model/crm_reports/dto/request/add_coupon_request.dart';
import '../../model/crm_reports/dto/request/crm_events_report_request.dart';
import '../../model/crm_reports/dto/response/crm_event_dto.dart';
import '../../provider/api_provider.dart';

class CrmReportsRepository {

  getEventsList(
      CrmEventsReportRequest request, {
        Function()? onComplete,
        Function(List<EventDTO> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
        ApiProvider().post<List<EventDTO> , List<dynamic>>('crmEvent/FindCrmEvent',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: EventDTO.fromList,
      );


  addCoupon(
      AddCouponRequest request, {
        Function()? onComplete,
        Function(void data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<void , Map<String,dynamic>>('offers/addCoupon',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: (_){},
      );
}