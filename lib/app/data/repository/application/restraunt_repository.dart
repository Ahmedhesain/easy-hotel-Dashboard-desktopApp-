
import 'package:hotel_manger/app/data/model/restraunt/dto/request/app_request_dto.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/app_response.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/app_value_response.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/best_selling_response.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/client_comments_response.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/client_masseges_response.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/group_value_for_day_and_month_response.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/list_purchase_response.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/most_buying_clients_response.dart';
import 'package:hotel_manger/app/data/provider/api_provider.dart';

class RestrauntAppRepository {

  getNumOrders(
      AppRequest request, {
        SuccessFunc<AppResponse> onSuccess,
        Function(dynamic error)? onError,  Function()?onComplete,
      }) {
    ApiProvider().post<AppResponse>(
        'salesReportNew/TheNumberOrders',
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: AppResponse.fromJson,
        onComplete: onComplete
    );
  }

  getNumberOrdersUnderProcessing(
      AppRequest request, {
        SuccessFunc<AppResponse> onSuccess,
        Function(dynamic error)? onError,  Function()?onComplete,
      }) {
    ApiProvider().post<AppResponse>(
        'salesReportNew/numberOrdersUnderProcessing',
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: AppResponse.fromJson,
        onComplete: onComplete
    );
  }
  getNumberOrdersUnderDelivery(
      AppRequest request, {
        SuccessFunc<AppResponse> onSuccess,
        Function(dynamic error)? onError,  Function()?onComplete,
      }) {
    ApiProvider().post<AppResponse>(
        'salesReportNew/numberOrdersUnderDelivery',
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: AppResponse.fromJson,
        onComplete: onComplete
    );
  }
  getListPurchase(
      AppRequest request, {
        SuccessFunc<ListPurchaseResponse> onSuccess,
        Function(dynamic error)? onError,  Function()?onComplete,
      }) {
    ApiProvider().post<ListPurchaseResponse>(
        'salesReportNew/listPurchase',
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: ListPurchaseResponse.fromJson,
        onComplete: onComplete
    );
  }
  getNumberOrdersDelivered(
      AppRequest request, {
        SuccessFunc<AppResponse> onSuccess,
        Function(dynamic error)? onError,  Function()?onComplete,
      }) {
    ApiProvider().post<AppResponse>(
        'salesReportNew/numberOrdersDelivered',
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: AppResponse.fromJson,
        onComplete: onComplete
    );
  }

  getNumberOrdersLate(
      AppRequest request, {
        SuccessFunc<AppResponse> onSuccess,
        Function(dynamic error)? onError,  Function()?onComplete,
      }) {
    ApiProvider().post<AppResponse>(
        'salesReportNew/NumberOrdersLate',
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: AppResponse.fromJson,
        onComplete: onComplete
    );
  }

  getTotalValueOrders(
      AppRequest request, {
        SuccessFunc<AppValueResponse> onSuccess,
        Function(dynamic error)? onError,  Function()?onComplete,
      }) {
    ApiProvider().post<AppValueResponse>(
        'salesReportNew/totalValueOrders',
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: AppValueResponse.fromJson,
        onComplete: onComplete
    );
  }

  getNewClient(
      AppRequest request, {
        SuccessFunc<AppResponse> onSuccess,
        Function(dynamic error)? onError,  Function()?onComplete,
      }) {
    ApiProvider().post<AppResponse>(
        'salesReportNew/newClient',
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: AppResponse.fromJson,
        onComplete: onComplete
    );
  }
  getSalesOfTheWeek(
      AppRequest request, {
        SuccessFunc<AppValueResponse> onSuccess,
        Function(dynamic error)? onError,  Function()?onComplete,
      }) {
    ApiProvider().post<AppValueResponse>(
        'salesReportNew/salesOfTheWeek',
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: AppValueResponse.fromJson,
        onComplete: onComplete
    );
  }
  getBestSelling(
      AppRequest request, {
        Function()? onComplete,
        SuccessFunc<List<BestSellingResponse>> onSuccess,
        Function(dynamic error)? onError,
      }) async =>
      await  ApiProvider().post<List<BestSellingResponse>>('salesReportNew/bestSellingItems',
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
      await  ApiProvider().post<List<MostBuingClientsResponse>>('salesReportNew/mostBuingClients',
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
      await  ApiProvider().post<List<GroupValueForDayAndMonthResponse>>('salesReportNew/groupValueForDayAndMonth',
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
      await  ApiProvider().post<List<ClientMassegesResponse>>('salesReportNew/clientMasseges',
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
      await  ApiProvider().post<List<ClientCommentsResponse>>('salesReportNew/clientComments',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: ClientCommentsResponse.fromList,
      );
}
