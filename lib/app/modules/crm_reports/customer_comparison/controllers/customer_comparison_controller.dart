


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/data/model/crm_reports/dto/request/customer_comparison_request.dart';

import '../../../../core/utils/show_popup_text.dart';
import '../../../../core/utils/user_manager.dart';
import '../../../../data/model/crm_reports/dto/response/customer_comparison_response.dart';
import '../../../../data/model/customer/dto/request/find_customer_request.dart';
import '../../../../data/model/customer/dto/response/find_customer_response.dart';
import '../../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../../../data/repository/crm_reports/crm_reports_repository.dart';
import '../../../../data/repository/customer/customer_repository.dart';
import '../../../home/controllers/home_controller.dart';

class CustomerComparisonController extends GetxController {
  final isLoading = false.obs ;
  Rxn<GalleryResponse> selectedGallery = Rxn();
  final galleries = <GalleryResponse>[].obs;
  Rxn<FindCustomerResponse> selectedCustomer = Rxn();
  Rxn<FindCustomerResponse> selectedCustomer2 = Rxn();
  final customers = <FindCustomerResponse>[];
  final customerFocusNode = FocusNode();
  final customer2FocusNode = FocusNode();
  final customer2Controller = TextEditingController();
  final customerController = TextEditingController();
  Rxn<DateTime> period1From = Rxn(DateTime.now());
  Rxn<DateTime> period2From = Rxn(DateTime.now());
  Rxn<DateTime> period1TO = Rxn(DateTime.now());
  Rxn<DateTime> period2TO = Rxn(DateTime.now());
  Rxn<CustomerComparisonResponse> reportResponse = Rxn();
  final totalInvoiceNumber = 0.obs ;
  final totalThobeNumber = 0.obs ;
  final totalValueNumber = 0.0.obs ;
  final invoicePercent = 0.5.obs;
  final thobePercent = 0.5.obs;
  final valuePercent = 0.5.obs;

  final formKey = GlobalKey<FormState>();

  @override
  onInit(){
    super.onInit();
    galleries.assignAll(Get.find<HomeController>().galleries);
    if(galleries.any((element) => element.id == UserManager().galleryId)) {
      selectedGallery(galleries.singleWhere((element) => element.id == UserManager().galleryId));
    }
  }

  Future<void> getCustomers(String search , int index) async {
    isLoading(true);
    index == 0 ? customerFocusNode.unfocus() : customer2FocusNode.unfocus() ;
    final request = FindCustomerRequest(code: search, branchId: UserManager().branchId, gallaryIdAPI: selectedGallery.value?.id);
    await CustomerRepository().findCustomerByCode(request,
        onSuccess: (data) {
          customers.assignAll(data);
          index == 0 ?  customerFocusNode.requestFocus() :  customer2FocusNode.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  search(){
    formKey.currentState?.validate();
    if(selectedCustomer.value == null){
      showPopupText(text: "يجب اختيار عميل اول");
      return ;
    }
    if(selectedCustomer2.value == null){
      showPopupText(text: "يجب اختيار عميل ثاني");
      return ;
    }
    if(period1From.value == null || period1TO.value == null){
      showPopupText(text: "يجب اختيار فترة اولي");
      return ;
    }
    if(period2From.value == null || period2TO.value == null){
      showPopupText(text: "يجب اختيار فترة ثانية");
      return ;
    }
    if(selectedGallery.value == null){
      showPopupText(text: "يجب اختيار معرض");
      return ;
    }

    isLoading(true);
    final request = CustomerComparisonRequest(
      firstCustomer: selectedCustomer.value?.id,
      firstDateFrom: period1From.value,
      firstDateTo:  period1TO.value,
      gallaryId: selectedGallery.value?.id ,
      secondCustomer: selectedCustomer2.value?.id,
      secondDateFrom: period2From.value,
      secondDateTo: period2TO.value
    );

    CrmReportsRepository().getCustomersComparisonReport(
        request,
       onComplete: () => isLoading(false),
       onError: (e) => showPopupText(text: e.toString()),
      onSuccess: (data){
        reportResponse(data);
        totalThobeNumber((data.firstCustomer.totalThobeNumber?.toInt() ?? 0) + (data.secondCustomer.totalThobeNumber?.toInt() ?? 0));
        totalInvoiceNumber(data.firstCustomer.totalInvoiceNumber ?? 0 + (data.secondCustomer.totalInvoiceNumber ?? 0));
        totalValueNumber(data.firstCustomer.totalInvoiceValue ?? 0 + (data.secondCustomer.totalInvoiceValue ?? 0));
        invoicePercent(((data.secondCustomer.totalInvoiceNumber ?? 0.0) / totalInvoiceNumber.value));
        valuePercent(((data.secondCustomer.totalInvoiceValue ?? 0.0) / totalValueNumber.value));
        thobePercent(((data.secondCustomer.totalThobeNumber ?? 0.0) / totalThobeNumber.value));
      }
    );
  }

}