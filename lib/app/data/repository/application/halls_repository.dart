
import 'package:hotel_manger/app/data/model/halls/dto/request/app_request_dto.dart';
import 'package:hotel_manger/app/data/model/halls/dto/response/app_response.dart';
import 'package:hotel_manger/app/data/model/halls/dto/response/app_value_response.dart';
import 'package:hotel_manger/app/data/model/halls/dto/response/best_selling_response.dart';
import 'package:hotel_manger/app/data/model/halls/dto/response/client_comments_response.dart';
import 'package:hotel_manger/app/data/model/halls/dto/response/client_masseges_response.dart';
import 'package:hotel_manger/app/data/model/halls/dto/response/group_value_for_day_and_month_response.dart';
import 'package:hotel_manger/app/data/model/halls/dto/response/list_purchase_response.dart';
import 'package:hotel_manger/app/data/model/halls/dto/response/most_buying_clients_response.dart';
import 'package:hotel_manger/app/data/model/halls/dto/response/sales_of_month_response.dart';
import 'package:hotel_manger/app/data/provider/api_provider.dart';

class HallsAppRepository {
  getNumOrders(
      AppRequest request, {
        Function()? onComplete,
        SuccessFunc<List<AppResponse>> onSuccess,
        Function(dynamic error)? onError,
      }) async =>
      await  ApiProvider().post<List<AppResponse>>('salesHoleReport/TheNumberOrdersNewDate',
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
      await  ApiProvider().post<List<AppResponse>>('salesHoleReport/getALLOrders',
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
      await  ApiProvider().post<List<AppResponse>>('salesHoleReport/getALLOrdersReservedNewDate',
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
      await  ApiProvider().post<List<AppResponse>>('salesHoleReport/TheNumberOrdersLate',
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
        'salesHoleReport/listPurchase',
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
        'salesHoleReport/totalValueOrders',
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
        'salesHoleReport/salesOfTheMonth',
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
      await  ApiProvider().post<List<BestSellingResponse>>('salesHoleReport/bestSellingItems',
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
      await  ApiProvider().post<List<MostBuingClientsResponse>>('salesHoleReport/mostBuingClients',
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
      await  ApiProvider().post<List<GroupValueForDayAndMonthResponse>>('salesHoleReport/groupValueForDayAndMonth',
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
      await  ApiProvider().post<List<ClientMassegesResponse>>('salesHoleReport/clientMasseges',
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
      await  ApiProvider().post<List<ClientCommentsResponse>>('salesHoleReport/clientComments',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: ClientCommentsResponse.fromList,
      );
}
