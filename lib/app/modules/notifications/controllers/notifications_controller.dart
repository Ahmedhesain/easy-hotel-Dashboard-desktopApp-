import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_balance_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/gallery_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_invoice_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_response.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';

class NotificationsController extends GetxController {

  final isLoading = false.obs;
  final notificationType = 0.obs;
  final Rxn<FindCustomerResponse> selectedCustomer = Rxn();
  final Rxn<DateTime> date = Rxn();
  final customers = <FindCustomerResponse>[];
  final galleries = <GalleryResponse>[];
  Rxn<GalleryResponse> selectedGallery = Rxn();
  Rxn<InvoiceResponse> invoice = Rxn();
  FindCustomerBalanceResponse? findCustomerBalanceResponse;

  final searchedInvoiceController = TextEditingController();
  final findSideCustomerController = TextEditingController();
  final priceController = TextEditingController();
  final remarksController = TextEditingController();
  final findSideCustomerFieldFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    getGalleries();
  }

  void getInvoiceListForCustomer(FindCustomerResponse value) {
    findSideCustomerController.text = "${value.name} ${value.code}";
    isLoading(true);
    CustomerRepository().findCustomerInvoicesData(
      FindCustomerBalanceRequest(id: value.id),
      onSuccess: (data) => findCustomerBalanceResponse = data,
      onError: (error) => showPopupText(text: error.toString()),
      onComplete: () => isLoading(false),
    );
  }

  getCustomersByCode() {
    isLoading(true);
    findSideCustomerFieldFocusNode.unfocus();
    final request = FindCustomerRequest(code: findSideCustomerController.text, branchId: UserManager().branchId, gallaryIdAPI: UserManager().galleryId);
    CustomerRepository().findCustomerByCode(request,
        onSuccess: (data) {
          customers.assignAll(data);
          findSideCustomerFieldFocusNode.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  searchForInvoiceById(String id) async {
    newInvoice();
    searchedInvoiceController.text = id;
    isLoading(true);
    await InvoiceRepository().findInvPurchaseInvoiceBySerial(GetInvoiceRequest(serial: id, branchId: UserManager().branchId, gallaryId: null),
        onSuccess: (data) {
          invoice(data);
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }


  newInvoice() {
    selectedCustomer.value = null;
    invoice.value = null;
    if(galleries.isNotEmpty) selectedGallery(galleries.first);
    searchedInvoiceController.clear();
    findSideCustomerController.clear();
    priceController.clear();
    remarksController.clear();
  }

  Future<void> getGalleries() {
    isLoading(true);
    return InvoiceRepository().getGalleries(
      GalleryRequest(branchId: UserManager().branchId, id: UserManager().id),
      onSuccess: (data) {
        galleries.assignAll(data);
        if(galleries.any((element) => element.id == UserManager().galleryId)){
          selectedGallery(galleries.singleWhere((element) => element.id == UserManager().galleryId));
        } else if (galleries.isNotEmpty) {
          selectedGallery(galleries.first);
        }
      },
      onError: (error) => showPopupText(text: error.toString()),
      onComplete: () => isLoading(false)
    );
  }
}
