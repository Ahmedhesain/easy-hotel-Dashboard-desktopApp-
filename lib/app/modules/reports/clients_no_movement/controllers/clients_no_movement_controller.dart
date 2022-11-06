import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_delivery_place_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/clients_no_movement_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/sales_of_items_by_company_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/client_no_movement_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/profit_of_items_sold_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/quantity_items_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/sales_of_items_by_company_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

import '../../../../data/model/reports/dto/request/quantity_items_request.dart';

class ClientsNoMovementController extends GetxController{

  final List<ClientsNoMovementResponse> _allReports = [];
  final reports = <ClientsNoMovementResponse>[].obs;
  final isLoading = true.obs;
  String query = '';
  final deliveryPlaces = <DeliveryPlaceResposne>[];
  Rxn<DeliveryPlaceResposne> selectedDeliveryPlace = Rxn();
  final Rxn<DateTime> dateFrom = Rxn();
  final Rxn<DateTime> dateTo = Rxn();






  @override
  void onInit() {
    super.onInit();
    getDeliveryPlaces();
    getClientNoMovement();

  }

  getClientNoMovement() async {
    isLoading(true);
    final request = ClientsNoMovementRequest(
      branchId: UserManager().branchId,
      dateFrom:dateFrom.value,
      invInventoryDtoList: [],
    );
    ReportsRepository().ClientsNoMovement(request,
        onSuccess: (data) {
          reports.assignAll(data);
          _allReports.assignAll(data);
        },
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }
  Future<void> getDeliveryPlaces() {
    return InvoiceRepository().findInventoryByBranch(
      DeliveryPlaceRequest(branchId: UserManager().branchId, id: UserManager().id),
      onSuccess: (data) {
        deliveryPlaces.assignAll(data);
        if (deliveryPlaces.isNotEmpty) {
          selectedDeliveryPlace(deliveryPlaces.first);
        }
      },
      onError: (error) => showPopupText(text: error.toString()),
    );
  }
  pickFromDate() async {
    dateFrom(await _pickDate(initialDate: dateFrom.value ?? DateTime.now(), firstDate: DateTime(2019), lastDate: dateTo.value ?? DateTime.now()));
  }


  _pickDate({required DateTime initialDate, required DateTime firstDate, required DateTime lastDate}) {
    return showDatePicker(context: Get.overlayContext!, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate);
  }


// Future<void> searchItem() async {
  //   reports.clear();
  //   reports.assignAll(_allReports.where((item) {
  //     final itemName = item.name?.toLowerCase();
  //     final searchLower = query.toLowerCase();
  //     return itemName!.contains(searchLower);
  //   }).toList());
  // }

}