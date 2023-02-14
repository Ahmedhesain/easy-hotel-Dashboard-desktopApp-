import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotel_manger/app/core/utils/show_popup_text.dart';
import 'package:hotel_manger/app/core/values/app_colors.dart';
import 'package:hotel_manger/app/data/model/spa/dto/request/app_request_dto.dart';
import 'package:hotel_manger/app/data/model/spa/dto/response/app_response.dart';
import 'package:hotel_manger/app/data/model/spa/dto/response/app_value_response.dart';
import 'package:hotel_manger/app/data/model/spa/dto/response/best_selling_response.dart';
import 'package:hotel_manger/app/data/model/spa/dto/response/client_comments_response.dart';
import 'package:hotel_manger/app/data/model/spa/dto/response/client_masseges_response.dart';
import 'package:hotel_manger/app/data/model/spa/dto/response/group_value_for_day_and_month_response.dart';
import 'package:hotel_manger/app/data/model/spa/dto/response/list_purchase_response.dart';
import 'package:hotel_manger/app/data/model/spa/dto/response/most_buying_clients_response.dart';
import 'package:hotel_manger/app/data/model/spa/dto/response/order_response.dart';
import 'package:hotel_manger/app/data/model/spa/dto/response/review_response.dart';
import 'package:hotel_manger/app/data/repository/application/spa_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


// import 'package:window_manager/window_manager.dart';
import '../../../core/enums/toast_msg_type.dart';
import '../../../core/values/app_constants.dart';

class SpaHomeController extends GetxController {

  final List <Color>gradientList =
  [
    AppColors.redOne,
    AppColors.blue,
  ];

  final isLoading = false.obs;
  final numOrders = 0.obs;
  final numOrdersList = <AppResponse>[].obs;
  final numberOrdersUnderProcessing = 0.obs;
  final numberOrdersUnderProcessingList = <AppResponse>[].obs;
  final numberOrdersDelivered = 0.obs;
  final numberOrdersDeliveredList = <AppResponse>[].obs;
  final numberOrdersLate = 0.obs;
  final numberOrdersLateList = <AppResponse>[].obs;
  final totalValueOrders = 0.0.obs;
  final best = 0.0.obs;
  final salesOfTheLast = 0.0.obs;
  final salesOfTheFirst = 0.0.obs;
  final all = 0.0.obs;
  ListPurchaseResponse? listPurchase ;
  final bestSellingList = <BestSellingResponse>[].obs;
  final mostBuyingClientsList = <MostBuingClientsResponse>[].obs;
  final groupValueForDayAndMonth = <GroupValueForDayAndMonthResponse>[].obs;
  final groupClientMasseges = <ClientMassegesResponse>[].obs;
  final clientComments = <ClientCommentsResponse>[].obs;

  final waitingList = <AppResponse>[].obs;
  final numWaitingList = 0.obs;
  Timer? countdownTimer;



  @override
  void onInit() {
    super.onInit();
    getNumOrders();



    getTotalValueOrders();
    getBestSelling();
    getMostBuingClients();
    getSalesOfTheWeek();
    getGroupValueForDayAndMonth();
    getClientMasseges();
    getClientComments();

    startTimer();
    final wsUrl = Uri.parse('ws://localhost:8005/ws/spaDashboard?filterId=232');
    final channel = WebSocketChannel.connect(wsUrl);
    channel.stream.listen((event) {

      final orders =OrderResponse.fromList(json.decode(event));
      for(int z=0;z<orders.length;z++) {
        AppResponse newOrder = AppResponse(id: orders[z].id,
            dueDate: orders[z].dueDate,
            dueTime: orders[z].dueTime);
        numOrdersList.add(newOrder);
        numOrders(numOrdersList.length);
        waitingList.add(newOrder);
        numWaitingList(waitingList.length);
        // salesOfTheFirst.value = (orders[z].salePrice! + salesOfTheFirst.value);
        totalValueOrders(orders[z].salePrice! + totalValueOrders.value);
        RxBool checkItem=true.obs;
        RxBool checkGroup=true.obs;
        RxBool checkClient=true.obs;
        for (int i = 0; i < bestSellingList.length; i++) {
          if (orders[z].spaItemId == bestSellingList[i].id) {
            bestSellingList[i].best + 1.0;
            checkItem.value = false;
          }
        }
        if (checkItem.value) {
          BestSellingResponse newBest = BestSellingResponse(
            id: orders[z].spaItemId!,
            name: orders[z].spaItemName,
            image: "",
            amount: 1,
            count: 1,
          );
          bestSellingList.add(newBest);
        }

        for(int i=0;i<groupValueForDayAndMonth.length;i++) {
          if (orders[z].groupId == groupValueForDayAndMonth[i].id) {
            ++groupValueForDayAndMonth[i].added;
            checkGroup.value = false;
            groupValueForDayAndMonth[i].valueOrderMonth =(orders[z].salePrice!  +groupValueForDayAndMonth[i].valueOrderMonth!);
            groupValueForDayAndMonth[i].valueOrderDay =(orders[z].salePrice! +groupValueForDayAndMonth[i].valueOrderDay!);

          }
        }
        if(checkGroup.value){
          GroupValueForDayAndMonthResponse group =GroupValueForDayAndMonthResponse(
              id: orders[z].groupId,
              name: orders[z].groupName,
              countOrderDay: 1,
              countOrderMonth: 1,
              valueOrderDay: orders[z].salePrice,
              valueOrderMonth: orders[z].salePrice
          );
          groupValueForDayAndMonth.add(group);
        }


        for(int i=0;i<mostBuyingClientsList.length;i++) {

          if(orders[0].customerId==mostBuyingClientsList[i].id){
            ++mostBuyingClientsList[i].added;
            checkClient.value=false;

          }
        }
        if(checkClient.value){
          MostBuingClientsResponse mostBuying =MostBuingClientsResponse(
              id: orders[0].customerId,
              name: orders[0].name,
              numbers: 1
          );
          mostBuyingClientsList.add(mostBuying);
        }


      }

    },
        onDone: () => print('done'),
        cancelOnError: false);

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

  //   final wsUrlReview = Uri.parse('ws://localhost:8005/ws/reviewCarDashboard?filterId=232');
  //   final channelReview = WebSocketChannel.connect(wsUrlReview);
  //   channelReview.stream.listen((event) {
  //     final comment =ReviewResponse.fromJson(json.decode(event));
  //     ClientCommentsResponse review=ClientCommentsResponse(
  //         id: comment.id,
  //       comment: comment.reviewText
  //     );
  //
  //     clientComments.add(review);
  //     clientComments.refresh();
  //
  //   },
  //       onDone: () => print('done'));
  //
  }
  //

  getNumOrders() async {
    isLoading(true);
    final request = AppRequest(
      branchId: 232,

    );
    SpaAppRepository().getNumOrders(request,
        onSuccess: (data) {
          numOrders(data.data.length);
          numOrdersList(data.data);
          waitingList(data.data);
          getNumberOrdersUnderProcessing();
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
    SpaAppRepository().getNumberOrdersUnderProcessing(request,
        onSuccess: (data) {
          numberOrdersUnderProcessing(data.data.length);
          numberOrdersUnderProcessingList(data.data);
          getNumberOrdersDelivered();
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
    SpaAppRepository().getNumberOrdersDelivered(request,
        onSuccess: (data) {
          numberOrdersDelivered(data.data.length);
          numberOrdersDeliveredList(data.data);
          getTheNumberOrdersLate();

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
    SpaAppRepository().getNumberOrdersLate( request,
        onSuccess: (data) {
          numberOrdersLate(data.data.length);
          numberOrdersLateList(data.data);
          updateNumWaitingList();
          numWaitingList(waitingList.length);

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
    SpaAppRepository().getTotalValueOrders(request,
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
    SpaAppRepository().getSalesOfTheWeek(request,
        onSuccess: (data) {
          salesOfTheLast(data.data.valueLastMonth);
          salesOfTheFirst(data.data.valueLastMonth);
          all.value=salesOfTheLast.value-salesOfTheFirst.value;
        },
        onError: (e) => showPopupText(  text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }

  getBestSelling(){
    isLoading(true);
    final request = AppRequest(
        branchId: 232,);
    SpaAppRepository().getBestSelling(
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
    SpaAppRepository().getMostBuyingClients(
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
    SpaAppRepository().getGroupValueForDayAndMonth(
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
    SpaAppRepository().getClientMasseges(
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
    SpaAppRepository().getClientComments(
      request,
      onSuccess: (data)async{
        clientComments.assignAll(data.data);


      },
      onComplete: ()=>isLoading(false),
      onError: (e) => showPopupText( text: e.toString()),
    );
  }
  editNums(AppResponse waitOrder){

    waitingList.removeWhere((element) =>element.id==waitOrder.id );
  }

  editListNums(List<AppResponse> waitOrders){
    for(int i =0;i<waitOrders.length;i++){
      editNums(waitOrders[i]);
    }
  }

  updateNumWaitingList(){
    editListNums(numberOrdersDeliveredList);
    editListNums(numberOrdersUnderProcessingList);
    editListNums(numberOrdersLateList);
  }
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(minutes: 1), (_){
          print("called");
          for(int i=0;i<waitingList.length;i++){
            if(waitingList[i].dueTime!.isAfter(DateTime.now())){
              final AppResponse response =  waitingList[i] ;
              waitingList.removeAt(i);
              numberOrdersLateList.add(response);
            }
          }
        });

  }

}
