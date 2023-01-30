


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/data/repository/crm_reports/crm_reports_repository.dart';

import '../../../../core/utils/show_popup_text.dart';
import '../../../../core/utils/user_manager.dart';
import '../../../../data/model/crm_reports/dto/request/customers_report_by_invoice_request.dart';
import '../../../../data/model/crm_reports/dto/response/customers_report_by_invoice_response.dart';
import '../../../../data/model/invoice/dto/request/gallery_request.dart';
import '../../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../../../data/repository/invoice/invoice_repository.dart';

class CustomersReportByInvoiceController extends GetxController {
  final isLoading = false.obs;
  final invoiceValueFrom = TextEditingController();
  final invoiceValueTo = TextEditingController();
  final invoiceNumberFrom = TextEditingController();
  final invoiceNumberTo = TextEditingController();
  Rxn<DateTime> invoiceDateFrom = Rxn(DateTime.now());
  Rxn<DateTime> invoiceDateTo = Rxn(DateTime.now());
  final deliveryPlaces = <GalleryResponse>[].obs;
  RxList <GalleryResponse> selectedDeliveryPlace = RxList();
  final reportList = <CustomersReportByInvoiceResponse>[].obs ;
  final sortIndex = 2.obs ;
  final reportType = 0.obs ;
  @override
  onInit(){
    isLoading(true);
    super.onInit();
    Future.wait([ getDeliveryPlaces()]).whenComplete(() => isLoading(false));
  }

  search(){
    isLoading(true);
    final request = CustomersReportByInvoiceRequest(
        gallarySelected: selectedDeliveryPlace.isNotEmpty ? selectedDeliveryPlace.map((element) => element.id).toList() : [],
        invoiceDateFrom: invoiceDateFrom.value,
        invoiceDateTo: invoiceDateTo.value,
        invoiceValueFrom: double.tryParse(invoiceValueFrom.text),
        invoiceValueTo: double.tryParse(invoiceValueTo.text),
        thobeNumberFrom: int.tryParse(invoiceNumberFrom.text),
        thobeNumberTo: int.tryParse(invoiceNumberTo.text),
        branchId: UserManager().branchId,
        findTotal: reportType.value
    );
    CrmReportsRepository().getCustomersReportByInvoice(
        request,
        onSuccess: (data){
          reportList.assignAll(data);
          onSort(true, 2);
        },
        onComplete: ()=> isLoading(false),
        onError: (e) => showPopupText(text: e.toString())
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

  onSort(bool sort , int index){
    switch(index){
        case 1 :
        reportList.sort((a,b) => b.invoiceDate!.compareTo(a.invoiceDate!));
        sortIndex(1);
        break;
        case 2 :
        reportList.sort((a,b) => b.invoiceValue!.compareTo(a.invoiceValue!));
        sortIndex(2);
        break;
        case 3 :
        reportList.sort((a,b) => b.thobeNumber!.compareTo(a.thobeNumber!));
        sortIndex(3);
        break;
    }
  }

}