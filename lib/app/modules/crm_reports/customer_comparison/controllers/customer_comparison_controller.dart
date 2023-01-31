


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/show_popup_text.dart';
import '../../../../core/utils/user_manager.dart';
import '../../../../data/model/customer/dto/request/find_customer_request.dart';
import '../../../../data/model/customer/dto/response/find_customer_response.dart';
import '../../../../data/model/invoice/dto/response/gallery_response.dart';
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

  }

}