


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';

import '../../../core/utils/show_popup_text.dart';
import '../../../core/utils/user_manager.dart';
import '../../../data/model/customer/dto/request/find_customer_request.dart';
import '../../../data/model/customer/dto/response/find_customer_response.dart';
import '../../../data/model/invoice/dto/request/gallery_request.dart';
import '../../../data/repository/customer/customer_repository.dart';
import '../../../data/repository/invoice/invoice_repository.dart';

class CrmEventController extends GetxController {

  final galleries = <GalleryResponse>[].obs ;
  Rxn<GalleryResponse> selectedCrmEventGallery = Rxn();
  final crmCustomerFieldFocusNode = FocusNode();
  final customers = <FindCustomerResponse>[].obs;
  final crmCustomerController = TextEditingController();
  Rxn<FindCustomerResponse> selectedCrmCustomer = Rxn();
  final isLoading = false.obs ;

  @override
  onInit(){
    super.onInit();
    getGalleries();
  }

  getCustomersByCodeForInvoice() {
    if(selectedCrmEventGallery.value ==null){
      showPopupText(text: 'يجب اختيار معرض');
      return ;
    }
    isLoading(true);
    crmCustomerFieldFocusNode.unfocus();
    final request =
    FindCustomerRequest(code: crmCustomerController.text, branchId: UserManager().branchId, gallaryIdAPI: selectedCrmEventGallery.value!.id!);
    CustomerRepository().findCustomerByCode(request,
        onSuccess: (data) {
          customers.assignAll(data);
          crmCustomerFieldFocusNode.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }


  Future<void> getGalleries() {
    isLoading(true);
    return InvoiceRepository().getGalleries(
      GalleryRequest(branchId: UserManager().branchId, id: UserManager().id),
      onSuccess: (data) {
        galleries.assignAll(data);
        if (galleries.any((element) => element.id == UserManager().galleryId)) {
          selectedCrmEventGallery(galleries.singleWhere((element) => element.id == UserManager().galleryId));
        } else if (galleries.isNotEmpty) {
          selectedCrmEventGallery(galleries.first);
        }
      },
      onError: (error) => showPopupText(text: error.toString()),
      onComplete: () => isLoading(false)
    );
  }

}