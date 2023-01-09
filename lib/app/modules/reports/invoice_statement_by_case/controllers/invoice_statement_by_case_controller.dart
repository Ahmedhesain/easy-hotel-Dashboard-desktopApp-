import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/gallery_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_delivery_place_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/invoice_statement_by_case_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoice_statement_by_case_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';

class InvoiceStatementByCaseController extends GetxController {
  //
  // final galleries = <GalleryResponse>[];
  // final selectedGalleries = RxList<GalleryResponse>();
  final invoices = RxList<InvoiceStatementByCaseResponse>();
  String? error;
  final isLoading = false.obs;
  final dateFrom = DateTime.now().obs;
  final dateTo = DateTime.now().obs;
  final selectedStatus = 4.obs;
  final statusList = [
    "بالمشغل",
    "ارسال للمعرض",
    "استلام بالمعرض",
    "تسليم للعميل",
    "بالمعرض",
  ];
  final deliveryPlaces = <GalleryResponse>[].obs;
  RxList <GalleryResponse> selectedDeliveryPlace = RxList();
  @override
  onInit(){
    super.onInit();
    getDeliveryPlaces();
  }


  getInvoices(BuildContext context) async {
    isLoading(true);

    final request = InvoiceStatementByCaseRequest(
        gallaryListSelected: selectedDeliveryPlace.map((e) => DtoList(id: e.id)).toList(),
      dateTo: dateTo.value,
      dateFrom: dateFrom.value,
      branchId: UserManager().branchId,
      dayNumbers: 4,
      invoiceStatus: selectedStatus.value
    );
    ReportsRepository().getInvoiceStatementByCase(request,
      onSuccess: invoices.assignAll,
      onError: (e) => showPopupText(text: e.toString()),
      onComplete:() => isLoading(false),
    );

  }

  pickFromDate() async {
    dateFrom(await _pickDate(
        initialDate: dateFrom.value,
        firstDate: DateTime(2019),
        lastDate: dateTo.value
    ));
  }

  pickToDate() async {
    dateTo(await _pickDate(
        initialDate: dateTo.value,
        firstDate: dateFrom.value,
        lastDate: DateTime.now()
    ));
  }

  _pickDate({required DateTime initialDate,required DateTime firstDate,required DateTime lastDate}){
    return showDatePicker(
        context: Get.overlayContext!,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate
    );
  }

  Future<void> getDeliveryPlaces() {
    return InvoiceRepository().getGalleries(
      GalleryRequest(branchId: UserManager().branchId, id: UserManager().id),
      onSuccess: (data) {
        data.insert(0, GalleryResponse(name: "تحديد الكل"));
        deliveryPlaces.assignAll(data);
        if (deliveryPlaces.isNotEmpty) {
          // selectedDeliveryPlace(deliveryPlaces.first);
        }
      },
      onError: (error) => showPopupText(text: error.toString()),
    );
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

}
