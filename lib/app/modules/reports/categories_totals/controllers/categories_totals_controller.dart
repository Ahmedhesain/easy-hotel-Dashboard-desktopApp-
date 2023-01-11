import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/gallery_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_delivery_place_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/categories_totals_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/group_list_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/categories_totals_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/group_list_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';

class CategoriesTotalsController extends GetxController {

  final manager = UserManager();
  final isLoading = true.obs;
  final dateFrom = DateTime.now().obs;
  final dateTo = DateTime.now().obs;
  String? error;
  int? invoiceTypeSelected;
  final symbols = <GroupListResponse>[].obs;
  final selectedSymbols = <GroupListResponse>[].obs;
  final salesReports = <CategoriesTotalsResponse>[].obs;
  final deliveryPlaces = <GalleryResponse>[].obs;
  RxList <GalleryResponse> selectedDeliveryPlace = RxList();

  @override
  onInit(){
    super.onInit();
    getGroupList();
    getDeliveryPlaces();
  }


  getReports() {
    isLoading(true);
    final request = CategoriesTotalsRequest(
      invoiceType: invoiceTypeSelected,
      // gallaryList: selectedDeliveryPlace.where((e) => e.id != -1).map((e) => DtoList(e.id!)).toList(),
        gallaryList:selectedDeliveryPlace.map((e) => DtoList(id: e.id)).toList(),
      branchId: manager.branchId,
      dateFrom: dateFrom.value,
      dateTo: dateTo.value,
      symbolDtoapiList: selectedSymbols.where((e) => e.id != -1).map((e) => SymbolDtoapiList(e.id!)).toList()
    );
    ReportsRepository().getCategoriesTotals(
      request,
      onSuccess: (data){
        double allCost = 0.0;
        double allCostAverage = 0.0 ;
        for(CategoriesTotalsResponse response in data){
          allCost += response.allCost ?? 0;
          allCostAverage += response.allAvarageCost ?? 0;
        }
        if(data.isNotEmpty){
          data[0].allCost = allCost ;
          data[0].allAvarageCost = allCostAverage;
          salesReports.assignAll(data);
        }
      },
      onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false),
    );
  }

  getGroupList() {
    isLoading(true);
    final request = GroupListRequest(branchId: manager.branchId, id: manager.id);
    ReportsRepository().getGroupList(
      request,
      onSuccess: (data) {

        symbols.assignAll(data);
        if(symbols.isNotEmpty){
          symbols.insert(0, const GroupListResponse(name: "تحديد الكل", id: -1));
        }
        selectedSymbols.assignAll(symbols);
      },
      onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false),
    );
  }


  selectNewSymbols(List<String> values) {
    if (!values.contains("تحديد الكل") && selectedSymbols.any((element) => element.name == "تحديد الكل")) {
      selectedSymbols.clear();
    } else if (!selectedSymbols.any((element) => element.name == "تحديد الكل") && values.contains("تحديد الكل")) {
      selectedSymbols.assignAll(symbols);
    } else {
      if (values.length < selectedSymbols.length && values.contains("تحديد الكل")) {
        values.remove("تحديد الكل");
      }
      selectedSymbols.assignAll(symbols.where((element) => values.contains(element.name)));
    }
  }


  selectNewDeliveryplace(List<String> values) {
    if (!values.contains("تحديد الكل") && selectedDeliveryPlace.any((element) => element.name == "تحديد الكل")) {
      selectedDeliveryPlace.clear();
    } else if (!selectedDeliveryPlace.any((element) => element.name == "تحديد الكل") && values.contains("تحديد الكل")) {
      selectedDeliveryPlace.assignAll(deliveryPlaces);
    } else {
      if (values.length < selectedDeliveryPlace.length && values.contains("تحديد الكل")) {
        values.remove("تحديد الكل");
      }
      selectedDeliveryPlace.assignAll(deliveryPlaces.where((element) => values.contains(element.name)));
    }
  }

  pickFromDate() async {
    dateFrom(await _pickDate(initialDate: dateFrom.value, firstDate: DateTime(2019), lastDate: dateTo.value));
  }

  pickToDate() async {
    dateTo(await _pickDate(initialDate: dateTo.value, firstDate: dateFrom.value, lastDate: DateTime.now()));
  }

  _pickDate({required DateTime initialDate, required DateTime firstDate, required DateTime lastDate}) {
    return showDatePicker(context: Get.overlayContext!, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate);
  }

  Future<void> getDeliveryPlaces() {
    return InvoiceRepository().getGalleries(
      GalleryRequest(branchId: UserManager().branchId, id: UserManager().id),
      onSuccess: (data) {
        data.insert(0, GalleryResponse(name: "تحديد الكل"));
        deliveryPlaces.assignAll(data);
        selectNewDeliveryplace(["تحديد الكل"]);
        // if (deliveryPlaces.isNotEmpty) {
        //   // deliveryPlaces.insert(0, );
        //
        //   // selectedDeliveryPlace(deliveryPlaces.first);
        // }
      },
      onError: (error) => showPopupText(text: error.toString()),
    );
  }


}
