import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotel_manger/app/core/utils/show_popup_text.dart';
import 'package:hotel_manger/app/core/values/app_colors.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/request/app_request_dto.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/app_response.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/app_value_response.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/best_selling_response.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/client_comments_response.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/client_masseges_response.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/group_value_for_day_and_month_response.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/list_purchase_response.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/most_buying_clients_response.dart';
import 'package:hotel_manger/app/data/model/restraunt/dto/response/order_response.dart';
import 'package:hotel_manger/app/data/repository/application/restraunt_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


// import 'package:window_manager/window_manager.dart';
import '../../../core/enums/toast_msg_type.dart';
import '../../../core/values/app_constants.dart';

class RestrauntHomeController extends GetxController {

  final List <Color>gradientList =
  [
    AppColors.redOne,
    AppColors.blue,
  ];

  final isLoading = false.obs;
  final numOrders = 0.obs;
  final numberOrdersUnderProcessing = 0.obs;
  AppResponse? numberOrdersUnderDelivery ;
  AppResponse? numberOrdersDelivered ;
  AppResponse? numberOrdersLate ;
  AppResponse? newClient ;
  AppValueResponse? totalValueOrders ;
  AppValueResponse? salesOfTheWeek ;
  ListPurchaseResponse? listPurchase ;
  final bestSellingList = <BestSellingResponse>[].obs;
  final mostBuyingClientsList = <MostBuingClientsResponse>[].obs;
  final groupValueForDayAndMonth = <GroupValueForDayAndMonthResponse>[].obs;
  final groupClientMasseges = <ClientMassegesResponse>[].obs;
  final clientComments = <ClientCommentsResponse>[].obs;




  @override
  void onInit() {
    super.onInit();
    getNumOrders();
    getNumberOrdersUnderProcessing();
    getNumberOrdersUnderDelivery();
    getNumberOrdersDelivered();
    getNumberOrdersLate();
    getTotalValueOrders();
    // getNewClient();
    getBestSelling();
    getMostBuingClients();
    getSalesOfTheWeek();
    getGroupValueForDayAndMonth();
    getClientMasseges();
    getListPurchase();
    getClientComments();
    final wsUrl = Uri.parse('ws://192.168.1.13:8005/ws/orderDashboard?filterId=232');
    final channel = WebSocketChannel.connect(wsUrl);
    channel.stream.listen((event) {
      final orders =OrderResponse.fromList(event);
      numOrders(++numOrders.value);
      numberOrdersUnderProcessing(++numberOrdersUnderProcessing.value);
      // for(int i=0;i<orders.length;i++)
      numOrders(orders[0].id);
      numOrders.refresh();
      numberOrdersUnderProcessing.refresh();

    },
        onDone: () => print('done'));

  }


  getNumOrders() async {
    isLoading(true);
    final request = AppRequest(
      branchId: 232,

    );
    RestrauntAppRepository().getNumOrders(request,
        onSuccess: (data) {
          numOrders(data.data.number);
          },
        onError: (e) => showPopupText(  text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }
  getNumberOrdersUnderProcessing() async {
    isLoading(true);
    final request = AppRequest(
      branchId: 232,

    );
    RestrauntAppRepository().getNumberOrdersUnderProcessing(request,
        onSuccess: (data) {
          numberOrdersUnderProcessing(data.data.number);
         },
        onError: (e) => showPopupText(  text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }

  getListPurchase() async {
    isLoading(true);
    final request = AppRequest(
      branchId: 232,

    );
    RestrauntAppRepository().getListPurchase(request,
        onSuccess: (data) {
          listPurchase=data.data;
          },
        onError: (e) => showPopupText(  text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }

  getNumberOrdersUnderDelivery() async {
    isLoading(true);
    final request = AppRequest(
      branchId: 232,

    );
    RestrauntAppRepository().getNumberOrdersUnderDelivery(request,
        onSuccess: (data) {
          numberOrdersUnderDelivery=data.data;
          },
        onError: (e) => showPopupText(  text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }
  getNumberOrdersDelivered() async {
    isLoading(true);
    final request = AppRequest(
      branchId: 232,

    );
    RestrauntAppRepository().getNumberOrdersDelivered(request,
        onSuccess: (data) {
          numberOrdersDelivered=data.data;
          },
        onError: (e) => showPopupText(  text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }

  getNumberOrdersLate() async {
    isLoading(true);
    final request = AppRequest(
      branchId: 232,

    );
    RestrauntAppRepository().getNumberOrdersLate(request,
        onSuccess: (data) {
          numberOrdersLate=data.data;
          },
        onError: (e) => showPopupText(  text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }

  getTotalValueOrders() async {
    isLoading(true);
    final request = AppRequest(
      branchId: 232,

    );
    RestrauntAppRepository().getTotalValueOrders(request,
        onSuccess: (data) {
          totalValueOrders=data.data;
          },
        onError: (e) => showPopupText(  text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }

  getNewClient() async {
    isLoading(true);
    final request = AppRequest(
      branchId: 232,

    );
    RestrauntAppRepository().getNewClient(request,
        onSuccess: (data) {
          newClient=data.data;
        },
        onError: (e) => showPopupText(  text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }

  getSalesOfTheWeek() async {
    isLoading(true);
    final request = AppRequest(
      branchId: 232,

    );
    RestrauntAppRepository().getSalesOfTheWeek(request,
        onSuccess: (data) {
          salesOfTheWeek=data.data;
        },
        onError: (e) => showPopupText(  text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }

  getBestSelling(){
    isLoading(true);
    final request = AppRequest(
        branchId: 232,);
    RestrauntAppRepository().getBestSelling(
      request,
      onSuccess: (data)async{
        bestSellingList.assignAll(data.data);


      },
      onComplete: ()=>isLoading(false),
      onError: (e) => showPopupText( text: e.toString()),
    );
  }

  getMostBuingClients(){
    isLoading(true);
    final request = AppRequest(
        branchId: 232,);
    RestrauntAppRepository().getMostBuyingClients(
      request,
      onSuccess: (data)async{
        mostBuyingClientsList.assignAll(data.data);


      },
      onComplete: ()=>isLoading(false),
      onError: (e) => showPopupText( text: e.toString()),
    );
  }


  getGroupValueForDayAndMonth(){
    isLoading(true);
    final request = AppRequest(
        branchId: 232,);
    RestrauntAppRepository().getGroupValueForDayAndMonth(
      request,
      onSuccess: (data)async{
        groupValueForDayAndMonth.assignAll(data.data);


      },
      onComplete: ()=>isLoading(false),
      onError: (e) => showPopupText( text: e.toString()),
    );
  }


  getClientMasseges(){
    isLoading(true);
    final request = AppRequest(
        branchId: 232,);
    RestrauntAppRepository().getClientMasseges(
      request,
      onSuccess: (data)async{
        groupClientMasseges.assignAll(data.data);


      },
      onComplete: ()=>isLoading(false),
      onError: (e) => showPopupText( text: e.toString()),
    );
  }

  getClientComments(){
    isLoading(true);
    final request = AppRequest(
        branchId: 232,);
    RestrauntAppRepository().getClientComments(
      request,
      onSuccess: (data)async{
        clientComments.assignAll(data.data);


      },
      onComplete: ()=>isLoading(false),
      onError: (e) => showPopupText( text: e.toString()),
    );
  }


}
