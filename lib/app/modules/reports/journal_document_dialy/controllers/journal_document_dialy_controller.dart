import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/cost_center/dto/request/get_cost_center_request.dart';
import 'package:toby_bills/app/data/model/cost_center/dto/response/cost_center_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_delivery_place_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/gl_account_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/categories_items_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/invoice_movement_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/journal_document_dialy_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/saled_for_period_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/categories_items_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoice_movement_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/journal_document_dialy_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/profit_of_items_sold_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/quantity_items_response.dart';
import 'package:toby_bills/app/data/provider/local_provider.dart';
import 'package:toby_bills/app/data/repository/cost_center/cost_center_repository.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

import '../../../../data/model/reports/dto/request/quantity_items_request.dart';

class JournalDocumentDailyController extends GetxController{

  final List<JournalDocumentDialyResponse> _allReports = [];
  final reports = <JournalDocumentDialyResponse>[].obs;
  final isLoading = false.obs;
  String query = '';
  final deliveryPlaces = <DeliveryPlaceResposne>[].obs;
   RxList <DeliveryPlaceResposne> selectedDeliveryPlace = RxList();
  final Rxn<DateTime> dateFrom = Rxn();
  final Rxn<DateTime> dateTo = Rxn();
  var fromkindController = TextEditingController();
  var tokindController = TextEditingController();
  var fromnumController = TextEditingController();
  var tonumController = TextEditingController();
  var enteredprice = TextEditingController();
  Rxn<GlAccountResponse> selectedFromAccount = Rxn();
  Rxn<GlAccountResponse> selectedToAccount = Rxn();

  final accounts = <GlAccountResponse>[].obs;
  final user = UserManager();
  final costCenters = <CostCenterResponse>[].obs;
  Rxn<CostCenterResponse> selectedFromCenter = Rxn();
  Rxn<CostCenterResponse> selectedToCenter = Rxn();












  @override
  void onInit() {
    super.onInit();
    getDeliveryPlaces();
    getGlAccounts();
    getCostCenters();

  }

  getJournalDocumentDialy() async {
    isLoading(true);
    final request = JournalDocumentDialyRequest(
      documentTypeFrom:null ,
      documentTypeTo:null,
      documentNumForm:int.parse(fromkindController.text),
      documentNumTo:int.parse(tokindController.text) ,
      journalNumForm:int.parse(fromnumController.text) ,
      journalNumTo:int.parse(tonumController.text) ,
      userFrom:null,
      userTo:null,
      postFlag: "",
      glAccountFrom:selectedFromAccount.value!.id ,
      glAccountTo:selectedToAccount.value!.id   ,
      costCenterFrom:selectedFromCenter.value!.id  ,
      costCenterTo:selectedToCenter.value!.id  ,
      adminUnitFrom:null,
      adminUnitTo:null,
      periodFrpm:dateFrom.value,
      periodTo:dateTo.value,
      value: null,
      branchId:UserManager().branchId,
    );
    ReportsRepository().JournalDocumentDaily(request,
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
        data.insert(0, DeliveryPlaceResposne(name: "تحديد الكل"));

        deliveryPlaces.assignAll(data);
        if (deliveryPlaces.isNotEmpty) {
          // deliveryPlaces.insert(0, );

          // selectedDeliveryPlace(deliveryPlaces.first);
        }
      },
      onError: (error) => showPopupText(text: error.toString()),
    );
  }

  pickToDate() async {
    dateTo(await _pickDate(initialDate: dateTo.value ?? DateTime.now(), firstDate: dateFrom.value ?? DateTime.now(), lastDate: DateTime.now()));
  }

  pickFromDate() async {
    dateFrom(await _pickDate(initialDate: dateFrom.value ?? DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now()));
  }

  _pickDate({required DateTime initialDate, required DateTime firstDate, required DateTime lastDate}) {
    return showDatePicker(context: Get.overlayContext!, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate);
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
  Future<void> getGlAccounts() async {
    accounts.assignAll(LocalProvider().getGlAccounts());
    if(accounts.isEmpty) {
      return InvoiceRepository().getGlAccountList(GlAccountRequest(user.branchId),
          onSuccess: (data) {
            accounts.assignAll(data);
            LocalProvider().saveGlAccounts(data);
          },
          onError: (error) => showPopupText(text: error.toString()));
    }
  }
  Future<void> getCostCenters() {
    isLoading(true);
    return CostCenterRepository().getAll(GetCostCenterRequest(branchId: user.branchId),
        onSuccess: (data) {
          costCenters.assignAll(data);
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false)
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