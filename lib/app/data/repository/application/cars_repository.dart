


import 'package:hotel_manger/app/data/model/cars/dto/request/app_request_dto.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/app_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/app_value_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/best_selling_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/client_comments_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/client_masseges_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/group_value_for_day_and_month_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/list_purchase_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/most_buying_clients_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/sales_of_month_response.dart';
import 'package:hotel_manger/app/data/provider/api_provider.dart';

class CarsAppRepository {
  getNumOrders(
      AppRequest request, {
        Function()? onComplete,
        SuccessFunc<List<AppResponse>> onSuccess,
        Function(dynamic error)? onError,
      }) async =>
      await  ApiProvider().post<List<AppResponse>>('salesCarReport/TheNumberOrders',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: AppResponse.fromList,
      );


  getNumberOrdersUnderProcessing(
      AppRequest request, {
        Function()? onComplete,
        SuccessFunc<List<AppResponse>> onSuccess,
        Function(dynamic error)? onError,
      }) async =>
      await  ApiProvider().post<List<AppResponse>>('salesCarReport/numberOrdersUnderProcessing',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: AppResponse.fromList,
      );




  getNumberOrdersDelivered(
      AppRequest request, {
        Function()? onComplete,
        SuccessFunc<List<AppResponse>> onSuccess,
        Function(dynamic error)? onError,
      }) async =>
      await  ApiProvider().post<List<AppResponse>>('salesCarReport/numberOrdersDelivered',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: AppResponse.fromList,
      );



  getNumberOrdersLate(
      AppRequest request, {
        Function()? onComplete,
        SuccessFunc<List<AppResponse>> onSuccess,
        Function(dynamic error)? onError,
      }) async =>
      await  ApiProvider().post<List<AppResponse>>('salesCarReport/TheNumberOrdersLate',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: AppResponse.fromList,
      );






  getListPurchase(
      AppRequest request, {
        SuccessFunc<ListPurchaseResponse> onSuccess,
        Function(dynamic error)? onError,  Function()?onComplete,
      }) {
    ApiProvider().post<ListPurchaseResponse>(
        'salesCarReport/listPurchase',
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: ListPurchaseResponse.fromJson,
        onComplete: onComplete
    );
  }

  getTotalValueOrders(
      AppRequest request, {
        SuccessFunc<AppValueResponse> onSuccess,
        Function(dynamic error)? onError,  Function()?onComplete,
      }) {
    ApiProvider().post<AppValueResponse>(
        'salesCarReport/totalValueOrders',
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: AppValueResponse.fromJson,
        onComplete: onComplete
    );
  }


  getSalesOfTheWeek(
      AppRequest request, {
        SuccessFunc<SalesOfMonthResponse> onSuccess,
        Function(dynamic error)? onError,  Function()?onComplete,
      }) {
    ApiProvider().post<SalesOfMonthResponse>(
        'salesCarReport/salesOfTheMonth',
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: SalesOfMonthResponse.fromJson,
        onComplete: onComplete
    );
  }
  getBestSelling(
      AppRequest request, {
        Function()? onComplete,
        SuccessFunc<List<BestSellingResponse>> onSuccess,
        Function(dynamic error)? onError,
      }) async =>
      await  ApiProvider().post<List<BestSellingResponse>>('salesCarReport/bestSellingItems',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: BestSellingResponse.fromList,
      );
  getMostBuyingClients(
      AppRequest request, {
        Function()? onComplete,
        SuccessFunc<List<MostBuingClientsResponse>> onSuccess,
        Function(dynamic error)? onError,
      }) async =>
      await  ApiProvider().post<List<MostBuingClientsResponse>>('salesCarReport/mostBuingClients',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: MostBuingClientsResponse.fromList,
      );
  getGroupValueForDayAndMonth(
      AppRequest request, {
        Function()? onComplete,
        SuccessFunc<List<GroupValueForDayAndMonthResponse>> onSuccess,
        Function(dynamic error)? onError,
      }) async =>
      await  ApiProvider().post<List<GroupValueForDayAndMonthResponse>>('salesCarReport/groupValueForDayAndMonth',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: GroupValueForDayAndMonthResponse.fromList,
      );
  getClientMasseges(
      AppRequest request, {
        Function()? onComplete,
        SuccessFunc<List<ClientMassegesResponse>> onSuccess,
        Function(dynamic error)? onError,
      }) async =>
      await  ApiProvider().post<List<ClientMassegesResponse>>('salesCarReport/clientMasseges',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: ClientMassegesResponse.fromList,
      );
  getClientComments(
      AppRequest request, {
        Function()? onComplete,
        SuccessFunc<List<ClientCommentsResponse>> onSuccess,
        Function(dynamic error)? onError,
      }) async =>
      await  ApiProvider().post<List<ClientCommentsResponse>>('salesCarReport/clientComments',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: ClientCommentsResponse.fromList,
      );
}
