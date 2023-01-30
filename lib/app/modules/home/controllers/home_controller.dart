import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotel_manger/app/core/utils/show_popup_text.dart';
import 'package:hotel_manger/app/core/values/app_colors.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/request/app_request_dto.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/app_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/app_value_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/best_selling_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/client_comments_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/client_masseges_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/group_value_for_day_and_month_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/list_purchase_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/most_buying_clients_response.dart';
import 'package:hotel_manger/app/data/model/housekeeping/dto/response/order_response.dart';
import 'package:hotel_manger/app/data/repository/application/app_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


// import 'package:window_manager/window_manager.dart';
import '../../../core/enums/toast_msg_type.dart';
import '../../../core/values/app_constants.dart';

class HomeController extends GetxController {

  final List <Color>gradientList =
  [
    AppColors.redOne,
    AppColors.blue,
  ];

  final isLoading = false.obs;
  final numOrders = 0.obs;
  final numberOrdersUnderProcessing = 0.obs;
  final numberOrdersDelivered = 0.obs;
  final numberOrdersLate = 0.obs;
  final totalValueOrders = 0.0.obs;
  final best = 0.0.obs;
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
    getNumberOrdersDelivered();
    getTheNumberOrdersLate();
    getTotalValueOrders();
    getBestSelling();
    getMostBuingClients();
    getSalesOfTheWeek();
    getGroupValueForDayAndMonth();
    getClientMasseges();
    getClientComments();
    final wsUrl = Uri.parse('ws://localhost:8005/ws/carDashboard?filterId=232');
    final channel = WebSocketChannel.connect(wsUrl);
    channel.stream.listen((event) {

      final orders =OrderResponse.fromJson(json.decode(event));
      numOrders(++numOrders.value);
      numberOrdersUnderProcessing(++numberOrdersUnderProcessing.value);
      totalValueOrders(orders.salePrice!+totalValueOrders.value);
      for(int i=0;i<bestSellingList.length;i++) {
        if(orders.carId==bestSellingList[i].id){
          bestSellingList[i].best+1.0;
      }
      }    for(int i=0;i<groupValueForDayAndMonth.length;i++) {
        if(orders.groupId==groupValueForDayAndMonth[i].id){
          ++groupValueForDayAndMonth[i].added;
          groupValueForDayAndMonth[i].valueOrderMonth = totalValueOrders.value;

        }
      }for(int i=0;i<mostBuyingClientsList.length;i++) {
        if(orders.customerId==mostBuyingClientsList[i].id){
          ++mostBuyingClientsList[i].added;

        }
      }

      numOrders.refresh();
      numberOrdersUnderProcessing.refresh();
      bestSellingList.refresh();
      groupValueForDayAndMonth.refresh();
      mostBuyingClientsList.refresh();

    },
        onDone: () => print('done'));

    // final wsUrlFinish = Uri.parse('ws://localhost:8005/ws/updateFinishedCarDashboard?filterId=232');
    // final channelFinish = WebSocketChannel.connect(wsUrlFinish);
    // channelFinish.stream.listen((event) {
    //   numberOrdersDelivered(++numberOrdersDelivered.value);
    //   numberOrdersUnderProcessing(--numberOrdersUnderProcessing.value);
    //   numberOrdersDelivered.refresh();
    //   numberOrdersUnderProcessing.refresh();
    //
    // },
    //     onDone: () => print('done'));

    // final wsUrlReview = Uri.parse('ws://localhost:8005/ws/reviewCarDashboard?filterId=232');
    // final channelReview = WebSocketChannel.connect(wsUrlReview);
    // channelReview.stream.listen((event) {
    //   numberOrdersDelivered(++numberOrdersDelivered.value);
    //   numberOrdersUnderProcessing(--numberOrdersUnderProcessing.value);
    //   numberOrdersDelivered.refresh();
    //   numberOrdersUnderProcessing.refresh();
    //
    // },
    //     onDone: () => print('done'));

  }


  getNumOrders() async {
    isLoading(true);
    final request = AppRequest(
      branchId: 232,

    );
    AppRepository().getNumOrders(request,
        onSuccess: (data) {
          numOrders(data.data.length);
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
    AppRepository().getNumberOrdersUnderProcessing(request,
        onSuccess: (data) {
          numberOrdersUnderProcessing(data.data.length);
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
    AppRepository().getNumberOrdersDelivered(request,
        onSuccess: (data) {
          numberOrdersDelivered(data.data.length);
          },
        onError: (e) => showPopupText(  text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }

  getTheNumberOrdersLate() async {
    isLoading(true);
    final request = AppRequest(
      branchId: 232,

    );
    AppRepository().getNumberOrdersDelivered(request,
        onSuccess: (data) {
          numberOrdersLate(data.data.length);
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
    AppRepository().getTotalValueOrders(request,
        onSuccess: (data) {
          totalValueOrders(data.data.value);

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
    AppRepository().getSalesOfTheWeek(request,
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
    AppRepository().getBestSelling(
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
    AppRepository().getMostBuyingClients(
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
    AppRepository().getGroupValueForDayAndMonth(
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
    AppRepository().getClientMasseges(
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
    AppRepository().getClientComments(
      request,
      onSuccess: (data)async{
        clientComments.assignAll(data.data);


      },
      onComplete: ()=>isLoading(false),
      onError: (e) => showPopupText( text: e.toString()),
    );
  }


}
