import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotel_manger/app/core/utils/show_popup_text.dart';
import 'package:hotel_manger/app/core/values/app_colors.dart';
import 'package:hotel_manger/app/data/model/cars/dto/request/app_request_dto.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/app_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/app_value_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/best_selling_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/client_comments_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/client_masseges_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/group_value_for_day_and_month_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/list_purchase_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/most_buying_clients_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/order_response.dart';
import 'package:hotel_manger/app/data/model/cars/dto/response/review_response.dart';
import 'package:hotel_manger/app/data/repository/application/cars_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


// import 'package:window_manager/window_manager.dart';
import '../../../core/enums/toast_msg_type.dart';
import '../../../core/values/app_constants.dart';

class CarsHomeController extends GetxController {

  final List <Color>gradientList =
  [
    AppColors.redOne,
    AppColors.blue,
  ];

  final isLoading = false.obs;
  final numOrders = 0.obs;
  final numOrdersList = <AppResponse>[].obs;
  final waitingList = <AppResponse>[].obs;
  final numberOrdersUnderProcessing = 0.obs;
  final numberOrdersUnderProcessingList = <AppResponse>[].obs;
  final numberOrdersDelivered = 0.obs;
  final numberOrdersDeliveredList = <AppResponse>[].obs;
  final numberOrdersLate = 0.obs;
  final numWaitingList = 0.obs;
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

    final wsUrl = Uri.parse('ws://localhost:8005/ws/carDashboard?filterId=232');
    final channel = WebSocketChannel.connect(wsUrl);
    channel.stream.listen((event) {
      final orders =OrderResponse.fromJson(json.decode(event));
      AppResponse newOrder=AppResponse(id: orders.id,dueDate: orders.dueDate,dueTime: orders.dueTime);
      numOrdersList.add(newOrder);
      numOrders(numOrdersList.length);
      waitingList.add(newOrder);
      numWaitingList(waitingList.length);

      // numberOrdersUnderProcessing(numberOrdersUnderProcessingList.length);
      salesOfTheFirst.value=(orders.salePrice!+salesOfTheFirst.value);
      salesOfTheLast.value=(orders.salePrice!+salesOfTheLast.value);
      totalValueOrders(orders.salePrice!+totalValueOrders.value);
      RxBool checkItem=true.obs;
      RxBool checkGroup=true.obs;
      RxBool checkClient=true.obs;
      for(int i=0;i<bestSellingList.length;i++) {
        if(orders.carId==bestSellingList[i].id){
          bestSellingList[i].best+1.0;
          checkItem.value=false;
      }
      }
      if(checkItem.value){
          BestSellingResponse newBest =BestSellingResponse(
            id:orders.carId!,
            name:orders.carName,
            image:"",
            amount:1,
            count:1,
          );
          bestSellingList.add(newBest);

      }

      for(int i=0;i<groupValueForDayAndMonth.length;i++) {
        if (orders.groupId == groupValueForDayAndMonth[i].id) {
          ++groupValueForDayAndMonth[i].added;
          checkGroup.value = false;
          groupValueForDayAndMonth[i].valueOrderMonth =(orders.salePrice!  +groupValueForDayAndMonth[i].valueOrderMonth!);
          groupValueForDayAndMonth[i].valueOrderDay =(orders.salePrice! +groupValueForDayAndMonth[i].valueOrderDay!);

        }
      }
        if(checkGroup.value){
          GroupValueForDayAndMonthResponse group =GroupValueForDayAndMonthResponse(
              id: orders.groupId,
              name: orders.groupName,
              countOrderDay: 1,
              countOrderMonth: 1,
              valueOrderDay: orders.salePrice,
              valueOrderMonth: orders.salePrice
          );
          groupValueForDayAndMonth.add(group);
        }


      for(int i=0;i<mostBuyingClientsList.length;i++) {

        if(orders.customerId==mostBuyingClientsList[i].id){
          ++mostBuyingClientsList[i].added;
          checkClient.value=false;

        }
      }
      if(checkClient.value){
        MostBuingClientsResponse mostBuying =MostBuingClientsResponse(
          id: orders.customerId,
          name: orders.customerName,
          numbers: 1
        );
        mostBuyingClientsList.add(mostBuying);
      }



    },
        onDone: () => print('done'),
    cancelOnError: false);

    final wsUrlFinish = Uri.parse('ws://localhost:8005/ws/updateFinishedCarDashboard?filterId=232');
    final channelFinish = WebSocketChannel.connect(wsUrlFinish);
    channelFinish.stream.listen((event) {
      final orders =OrderResponse.fromJson(json.decode(event));
      AppResponse newOrder=AppResponse(id: orders.id,dueDate: orders.dueDate,dueTime: orders.dueTime);
      numberOrdersDeliveredList.add(newOrder);
      editNums(newOrder);
      numberOrdersDelivered(++numberOrdersDelivered.value);
      numberOrdersUnderProcessing(--numberOrdersUnderProcessing.value);
      numberOrdersDelivered.refresh();
      numberOrdersUnderProcessing.refresh();

    },
        onDone: () => print('done'));

    final wsUrlReview = Uri.parse('ws://localhost:8005/ws/reviewSPaDashboard?filterId=232');
    final channelReview = WebSocketChannel.connect(wsUrlReview);
    channelReview.stream.listen((event) {
      final comment =ReviewResponse.fromJson(json.decode(event));
      ClientCommentsResponse review=ClientCommentsResponse(
          id: comment.id,
        comment: comment.reviewText
      );

      clientComments.add(review);
      clientComments.refresh();

    },
        onDone: () => print('done'));

  }


  getNumOrders() async {
    isLoading(true);
    final request = AppRequest(
      branchId: 232,

    );
    AppRepository().getNumOrders(request,
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
    AppRepository().getNumberOrdersUnderProcessing(request,
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
    AppRepository().getNumberOrdersDelivered(request,
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
    AppRepository().getNumberOrdersLate( request,
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
