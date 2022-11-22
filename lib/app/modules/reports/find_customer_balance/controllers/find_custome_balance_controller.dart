import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_balance_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_delivery_place_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/clients_no_movement_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/find_custome_balance_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/sales_of_items_by_company_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/client_no_movement_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/profit_of_items_sold_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/quantity_items_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/sales_of_items_by_company_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

import '../../../../data/model/reports/dto/request/quantity_items_request.dart';

class FindCustomerBalanceController extends GetxController{

  final List<FindCustomersBalanceResponse> _allReports = [];
  final reports = <FindCustomersBalanceResponse>[].obs;
  final isLoading = false.obs;
  String query = '';
  final deliveryPlaces = <DeliveryPlaceResposne>[].obs;
  Rxn<DeliveryPlaceResposne> selectedDeliveryPlace = Rxn();
  final Rxn<DateTime> dateFrom = Rxn();
  final Rxn<DateTime> dateTo = Rxn();






  @override
  void onInit() {
    super.onInit();
    getDeliveryPlaces();


  }

  getClientBalance() async {
    isLoading(true);
    final request = FindCustomersBalanceRequest(
      branchId: UserManager().branchId,
      gallarySellected: GallarySellected(id: selectedDeliveryPlace.value!.id),
    );
    ReportsRepository().FindCustomerBalance(request,
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


// Future<void> searchItem() async {
  //   reports.clear();
  //   reports.assignAll(_allReports.where((item) {
  //     final itemName = item.name?.toLowerCase();
  //     final searchLower = query.toLowerCase();
  //     return itemName!.contains(searchLower);
  //   }).toList());
  // }

}