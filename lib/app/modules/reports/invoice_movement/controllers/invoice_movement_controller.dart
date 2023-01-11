import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/gallery_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_delivery_place_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/categories_items_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/invoice_movement_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/saled_for_period_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/categories_items_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoice_movement_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/profit_of_items_sold_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/quantity_items_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

import '../../../../data/model/reports/dto/request/quantity_items_request.dart';

class InvoiceMovementController extends GetxController{

  final List<InvoiceMovementResponse> _allReports = [];
  final reports = <InvoiceMovementResponse>[].obs;
  final isLoading = false.obs;
  String query = '';
  final deliveryPlaces = <GalleryResponse>[].obs;
   RxList <GalleryResponse> selectedDeliveryPlace = RxList();
  final Rxn<DateTime> dateFrom = Rxn();
  final Rxn<DateTime> dateTo = Rxn();
  var fromController = TextEditingController();
  var toController = TextEditingController();
  int? invoiceTypeSelected;
  final checkBoxValueNotComplete =false.obs;








  @override
  void onInit() {
    super.onInit();
    getDeliveryPlaces();


  }

  getInvoiceMovement() async {
    isLoading(true);
    final request = InvoiceMovementRequest(
      dateFrom:dateFrom.value,
      dateTo: dateTo.value,
      invoiceType: invoiceTypeSelected,
      invoiceFrom: int.tryParse(fromController.text),
      invoiceTo: int.tryParse(toController.text),
      invInventoryDtoList: selectedDeliveryPlace.map((e) => DtoList(id: e.id)).toList(),
      branchId:UserManager().branchId,
    );
    ReportsRepository().InvoiceMovement(request,
        onSuccess: (data) {
          reports.assignAll(data);
          _allReports.assignAll(data);
        },
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }
  Future<void> getDeliveryPlaces() {
    return InvoiceRepository().getGalleries(
      GalleryRequest(branchId: UserManager().branchId, id: UserManager().id),
      onSuccess: (data) {
        data.insert(0, GalleryResponse(name: "تحديد الكل"));

        deliveryPlaces.assignAll(data);
        if (deliveryPlaces.isNotEmpty) {
          selectNewDeliveryplace([ "تحديد الكل"]);
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

// Future<void> searchItem() async {
  //   reports.clear();
  //   reports.assignAll(_allReports.where((item) {
  //     final itemName = item.name?.toLowerCase();
  //     final searchLower = query.toLowerCase();
  //     return itemName!.contains(searchLower);
  //   }).toList());
  // }

}