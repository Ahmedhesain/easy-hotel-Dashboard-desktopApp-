
import 'package:hotel_manger/app/data/model/housekeeping/dto/request/app_request_dto.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/app_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/app_value_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/best_selling_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/client_comments_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/client_masseges_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/group_value_for_day_and_month_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/list_purchase_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/most_buying_clients_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/sales_of_month_response.dart';
import 'package:hotel_manger/app/data/provider/api_provider.dart';

class HouseKeepingAppRepository {
  getNumOrders(
      AppRequest request, {
        Function()? onComplete,
        SuccessFunc<List<AppResponse>> onSuccess,
        Function(dynamic error)? onError,
      }) async =>
      await  ApiProvider().post<List<AppResponse>>('salesHouseReport/TheNumberOrders',
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
      await  ApiProvider().post<List<AppResponse>>('salesHouseReport/numberOrdersUnderProcessing',
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
      await  ApiProvider().post<List<AppResponse>>('salesHouseReport/numberOrdersDelivered',
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
      await  ApiProvider().post<List<AppResponse>>('salesHouseReport/TheNumberOrdersLate',
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
        'salesHouseReport/listPurchase',
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
        'salesHouseReport/totalValueOrders',
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
        'salesHouseReport/salesOfTheMonth',
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
      await  ApiProvider().post<List<BestSellingResponse>>('salesHouseReport/bestSellingItems',
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
      await  ApiProvider().post<List<MostBuingClientsResponse>>('salesHouseReport/mostBuingClients',
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
      await  ApiProvider().post<List<GroupValueForDayAndMonthResponse>>('salesHouseReport/groupValueForDayAndMonth',
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
      await  ApiProvider().post<List<ClientMassegesResponse>>('salesHouseReport/clientMasseges',
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
      await  ApiProvider().post<List<ClientCommentsResponse>>('salesHouseReport/clientComments',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: ClientCommentsResponse.fromList,
      );
}
