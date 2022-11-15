import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/account_statement_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/account_statement_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

import '../../../core/utils/show_popup_text.dart';

class CustomerAccountStatementController extends GetxController {


  final List<AccountStatementResponse> reports = [];
  final isLoading = false.obs;
  final user = UserManager();
  final galleries = <GalleryResponse>[].obs;
  final customers = <FindCustomerResponse>[];
  Rxn<FindCustomerResponse> selectedCustomer = Rxn();
  Rxn<GalleryResponse> selectedGallery = Rxn();
  final customerFocusNode = FocusNode();
  final customerController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    galleries.assignAll(Get.find<HomeController>().galleries);
    if(galleries.any((element) => element.id == user.galleryId)) {
      selectedGallery(galleries.singleWhere((element) => element.id == user.galleryId));
    }
  }

  Future<void> getCustomers(String search) async {
    isLoading(true);
    customerFocusNode.unfocus();
    final request = FindCustomerRequest(code: search, branchId: user.branchId, gallaryIdAPI: selectedGallery.value?.id);
    await CustomerRepository().findCustomerByCode(request,
        onSuccess: (data) {
          customers.assignAll(data);
          customerFocusNode.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  getStatements() async {
    isLoading(true);
    final request = AccountStatementRequest(id: selectedCustomer.value!.id!);
    CustomerRepository().getCustomerAccountStatement(request,
        onSuccess: (data) => reports.assignAll(data),
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }


}
