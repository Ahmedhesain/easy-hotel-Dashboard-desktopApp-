import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_delivery_place_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/inv_item_dto_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/inv_item_dto_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/profit_of_items_sold_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/quantity_items_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

import '../../../../data/model/reports/dto/request/quantity_items_request.dart';

class InvItemController extends GetxController{

  final List<InvItemDtoResponse> _allReports = [];
  final reports = <InvItemDtoResponse>[].obs;
  final isLoading = false.obs;
  String query = '';
  final deliveryPlaces = <DeliveryPlaceResposne>[].obs;
  Rxn<DeliveryPlaceResposne> selectedDeliveryPlace = Rxn();
  final Rxn<DateTime> dateFrom = Rxn();
  final Rxn<DateTime> dateTo = Rxn();
  var categoryController = TextEditingController();
  final groups = <AllGroupResponse>[].obs;
  RxList <AllGroupResponse> selectedGroup = RxList();
  final Map<int, String> discBasis = {
    1: "عرض",
    2: "عرضين",

  };
  final selectedStatus=1.obs;
  final checkBoxValue =false.obs;






  @override
  void onInit() {
    super.onInit();
    getGroups();

  }

  getInvItemSold() async {
    isLoading(true);
    final request = InvItemDtoRequest(
      dateFrom:dateFrom.value,
      proGroupDtoList: selectedGroup.map((e) => ProGroupDtoList(id: e.id)).toList(),
      branchId:UserManager().branchId,
      isUsed: checkBoxValue.value,
      itemNatural: selectedStatus.value,
      lastCost: categoryController.text
    );
    ReportsRepository().InvItem(request,
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

  pickToDate() async {
    dateTo(await _pickDate(initialDate: dateTo.value ?? DateTime.now(), firstDate: dateFrom.value ?? DateTime.now(), lastDate: DateTime.now()));
  }
  _pickDate({required DateTime initialDate, required DateTime firstDate, required DateTime lastDate}) {
    return showDatePicker(context: Get.overlayContext!, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate);
  }

  Future<void> getGroups() {
    return ReportsRepository().groupStatement(
      AllGroupsRequest(branchId: UserManager().branchId, id: UserManager().id),
      onSuccess: (data) {
        groups.assignAll(data);
        if (groups.isNotEmpty) {
        }
      },
      onError: (error) => showPopupText(text: error.toString()),
    );
  }
  selectNewDeliveryplace(List<String> values) {
    if (!values.contains("تحديد الكل") && selectedGroup.any((element) => element.name == "تحديد الكل")) {
      selectedGroup.clear();
    } else if (!selectedGroup.any((element) => element.name == "تحديد الكل") && values.contains("تحديد الكل")) {
      selectedGroup.assignAll(groups);
    } else {
      if (values.length < selectedGroup.length && values.contains("تحديد الكل")) {
        values.remove("تحديد الكل");
      }
      selectedGroup.assignAll(groups.where((element) => values.contains(element.name)));
    }
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