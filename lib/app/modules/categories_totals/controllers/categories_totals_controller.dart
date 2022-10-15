import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/group_list_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/categories_totals_response.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';

import '../../../data/model/reports/dto/request/categories_totals_request.dart';
import '../../../data/model/reports/dto/response/group_list_response.dart';

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

  @override
  onInit(){
    super.onInit();
    getGroupList();
  }


  getReports() {
    isLoading(true);
    final request = CategoriesTotalsRequest(
      invoiceType: invoiceTypeSelected,
      gallaryId: manager.galleryId,
      branchId: manager.branchId,
      dateFrom: dateFrom.value,
      dateTo: dateTo.value,
      symbolDtoapiList: selectedSymbols.where((e) => e.id != -1).map((e) => SymbolDtoapiList(e.id!)).toList()
    );
    ReportsRepository().getCategoriesTotals(
      request,
      onSuccess: (data) => salesReports.assignAll(data),
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

  pickFromDate() async {
    dateFrom(await _pickDate(initialDate: dateFrom.value, firstDate: DateTime(2019), lastDate: dateTo.value));
  }

  pickToDate() async {
    dateTo(await _pickDate(initialDate: dateTo.value, firstDate: dateFrom.value, lastDate: DateTime.now()));
  }

  _pickDate({required DateTime initialDate, required DateTime firstDate, required DateTime lastDate}) {
    return showDatePicker(context: Get.overlayContext!, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate);
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
}
