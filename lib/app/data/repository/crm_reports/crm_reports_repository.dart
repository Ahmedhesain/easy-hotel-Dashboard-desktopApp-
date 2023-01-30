


import 'package:toby_bills/app/data/model/crm_reports/dto/request/customers_report_request.dart';

import '../../model/crm_reports/dto/company_dto.dart';
import '../../model/crm_reports/dto/request/add_coupon_request.dart';
import '../../model/crm_reports/dto/request/crm_events_report_request.dart';
import '../../model/crm_reports/dto/request/customers_report_by_invoice_request.dart';
import '../../model/crm_reports/dto/request/send_msg_request.dart';
import '../../model/crm_reports/dto/response/crm_event_dto.dart';
import '../../model/crm_reports/dto/response/customers_report_by_invoice_response.dart';
import '../../model/crm_reports/dto/response/customers_report_response.dart';
import '../../model/crm_reports/dto/response/send_msg_response.dart';
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

  getCompanyList(
      CompanyDTO request, {
        Function()? onComplete,
        Function(List<CompanyDTO>  data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<CompanyDTO> , List<dynamic>>('customer/getOferCompanyDTOList',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: CompanyDTO.fromList,
      );

  getCustomerReport(
      CustomersReportRequest request, {
        Function()? onComplete,
        Function(List<CustomersReportResponse>  data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<CustomersReportResponse> , List<dynamic>>('crmReportsRest/findClientsByInvInventory',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: CustomersReportResponse.fromList,
      );

  sendMsg(
      SendMsgRequest request, {
        Function()? onComplete,
        Function(SendMsgResponse data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<SendMsgResponse,Map<String , dynamic>>('crmEvent/sendMsg',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: SendMsgResponse.fromJson,
      );

  getCustomersReportByInvoice(
      CustomersReportByInvoiceRequest request, {
        Function()? onComplete,
        Function(List<CustomersReportByInvoiceResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<CustomersReportByInvoiceResponse>,List<dynamic>>('crmReportsRest/findCrmCustomerData',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: CustomersReportByInvoiceResponse.fromList,
      );
}