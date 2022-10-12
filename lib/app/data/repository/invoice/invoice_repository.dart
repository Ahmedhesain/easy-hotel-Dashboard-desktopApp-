import 'package:toby_bills/app/data/model/invoice/dto/request/create_invoice_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_delivery_place_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_due_date_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_invoice_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/create_invoice_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delegator_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_due_date_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/save_tarhil_response.dart';
import 'package:toby_bills/app/data/provider/api_provider.dart';
import '../../model/customer/dto/request/find_customer_request.dart';
import '../../model/customer/dto/response/find_customer_response.dart';
import '../../model/invoice/dto/request/get_delegator_request.dart';
import '../../model/invoice/dto/response/get_delivery_place_response.dart';

class InvoiceRepository {

  findCustomerByCode(
      FindCustomerRequest findCustomerRequest, {
        Function()? onComplete,
        Function(List<FindCustomerResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<List<FindCustomerResponse>,List<dynamic>>('customer/findBy',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: findCustomerRequest.toJson(),
        onError: onError,
        convertor: FindCustomerResponse.getList,
    );

  findDueDateDTOAPI(
      GetDueDateRequest getDueDateRequest, {
        Function()? onComplete,
        Function(GetDueDateResponse data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<GetDueDateResponse,Map<String,dynamic>>('inventory/findDueDateDTOAPI',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: getDueDateRequest.toJson(),
        onError: onError,
        convertor: GetDueDateResponse.fromJson,
    );

  findInventoryByBranch(
      DeliveryPlaceRequest getBranchesRequest, {
        Function()? onComplete,
        Function(List<DeliveryPlaceResposne> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<List<DeliveryPlaceResposne>,List<dynamic>>('inventory/findInventoryByBranch',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: getBranchesRequest.toJson(),
        onError: onError,
        convertor: DeliveryPlaceResposne.getList,
    );

  findDelegatorByInventory(
      DelegatorRequest delegatorRequest, {
        Function()? onComplete,
        Function(List<DelegatorResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<List<DelegatorResponse>,List<dynamic>>('delegator/findDelegatorByInventory',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: delegatorRequest.toJson(),
        onError: onError,
        convertor: DelegatorResponse.getList,
    );

  findInvPurchaseInvoiceBySerial(
      GetInvoiceRequest getInvoiceRequest, {
        Function()? onComplete,
        Function(InvoiceResponse data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<InvoiceResponse,Map<String, dynamic>>('sales/findInvPurchaseInvoiceByserial',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: getInvoiceRequest.toJson(),
        onError: onError,
        convertor: InvoiceResponse.fromJson,
    );

  saveInvoice(
      CreateInvoiceRequest createInvoiceRequest, {
        Function()? onComplete,
        Function(InvoiceResponse data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<InvoiceResponse,Map<String, dynamic>>('sales/saveDeskTop',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: createInvoiceRequest.toJson(),
        onError: onError,
        convertor: InvoiceResponse.fromJson,
    );

  saveTarhil(
      InvoiceResponse invoiceModel, {
        Function()? onComplete,
        Function(SaveTarhilResponse data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<SaveTarhilResponse,Map<String, dynamic>>('sales/tarhilSalesAPI',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: invoiceModel.toJson(),
        onError: onError,
        convertor: SaveTarhilResponse.fromJson,
    );


}
