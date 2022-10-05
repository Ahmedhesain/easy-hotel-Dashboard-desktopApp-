import 'package:toby_bills/app/data/model/customer/dto/request/create_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_balance_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/provider/api_provider.dart';
import '../../model/customer/dto/request/find_customer_request.dart';
import '../../model/customer/dto/response/find_customer_response.dart';

class CustomerRepository {

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

  findCustomerInvoicesData(
      FindCustomerBalanceRequest findCustomerBalanceRequest, {
        Function()? onComplete,
        Function(FindCustomerBalanceResponse data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<FindCustomerBalanceResponse,Map<String, dynamic>>('customer/findCustomerInvoicesData',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: findCustomerBalanceRequest.toJson(),
        onError: onError,
        convertor: FindCustomerBalanceResponse.fromJson,
    );

  createCustomer(
      CreateCustomerRequest createCustomerRequest, {
        Function()? onComplete,
        Function(FindCustomerResponse data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<FindCustomerResponse,Map<String,dynamic>>('customer/addNewCustomer',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: createCustomerRequest.toJson(),
        onError: onError,
        convertor: FindCustomerResponse.fromJson,
    );

  getCustomerBalance(
        FindCustomerBalanceRequest findCustomerBalanceRequest, {
        Function()? onComplete,
        Function(num data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<num,Map<String,dynamic>>('customer/customerBalance',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: findCustomerBalanceRequest.toJson(),
        onError: onError,
        convertor: (Map<String,dynamic> json) => json["value"],
    );


}
