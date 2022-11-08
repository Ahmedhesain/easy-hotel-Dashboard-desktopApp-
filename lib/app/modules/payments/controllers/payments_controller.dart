import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';
import 'package:toby_bills/app/core/extensions/string_ext.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/cost_center/dto/request/get_cost_center_request.dart';
import 'package:toby_bills/app/data/model/cost_center/dto/response/cost_center_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_balance_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/gallery_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_invoice_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/gl_account_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_response.dart';
import 'package:toby_bills/app/data/model/notifications/dto/request/delete_notification_request.dart';
import 'package:toby_bills/app/data/model/notifications/dto/request/find_notification_request.dart';
import 'package:toby_bills/app/data/model/notifications/dto/request/save_notification_request.dart';
import 'package:toby_bills/app/data/model/notifications/dto/response/find_notification_response.dart';
import 'package:toby_bills/app/data/provider/local_provider.dart';
import 'package:toby_bills/app/data/repository/cost_center/cost_center_repository.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/notifications/notifications_repository.dart';

class PaymentsController extends GetxController {

  final isLoading = true.obs;
  final destinationType = 0.obs;
  final Rxn<FindCustomerResponse> selectedCustomer = Rxn();
  final Rx<DateTime> date = Rx(DateTime.now());
  final customers = <FindCustomerResponse>[];
  final accounts = <GlAccountResponse>[];
  final galleries = <GalleryResponse>[];
  final costCenters = <CostCenterResponse>[];
  Rxn<CostCenterResponse> selectedCenter = Rxn();
  Rxn<CostCenterResponse> itemSelectedCenter = Rxn();
  Rxn<GalleryResponse> selectedGallery = Rxn();
  Rxn<GlAccountResponse> selectedAccount = Rxn();
  Rxn<GlAccountResponse> selectedItemAccount = Rxn();
  Rxn<InvoiceResponse> invoice = Rxn();
  Rxn<FindNotificationResponse> notification = Rxn();
  FindCustomerBalanceResponse? findCustomerBalanceResponse;
  final user = UserManager();
  final searchedItemInvoiceController = TextEditingController();
  final notificationNumberController = TextEditingController();
  final findSideCustomerController = TextEditingController();
  final monawlaController = TextEditingController();
  final remarksController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemCommissionController = TextEditingController();
  final itemRemarksController = TextEditingController();
  final findSideCustomerFieldFocusNode = FocusNode();
  final searchedItemInvoiceFocusNode = FocusNode();
  final itemAccountFocusNode = FocusNode();

  @override
  void onInit() async {
    super.onInit();
    await getGlAccounts();
    await getGalleries();
    getCostCenters();
  }

  changeDestination(int? value){
    destinationType(value);
    customers.clear();
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

  void getInvoiceListForCustomer(FindCustomerResponse value) {
    findSideCustomerController.text = "${value.name} ${value.code}";
    selectedCustomer(value);
    isLoading(true);
    CustomerRepository().findCustomerInvoicesData(
      FindCustomerBalanceRequest(id: value.id),
      onSuccess: (data) {
        findCustomerBalanceResponse = data;
        searchedItemInvoiceFocusNode.requestFocus();
      },
      onError: (error) => showPopupText(text: error.toString()),
      onComplete: () => isLoading(false),
    );
  }

  getCustomers(){
    isLoading(true);
    findSideCustomerFieldFocusNode.unfocus();
    final request = FindCustomerRequest(code: findSideCustomerController.text, branchId: user.branchId, gallaryIdAPI: selectedGallery.value?.id);
    if(destinationType.value == 0) {
      _getCustomersByCode(request);
    } else {
      _getSupplierByCode(request);
    }
  }

  _setCustomers(List<FindCustomerResponse> data){
    customers.assignAll(data);
    findSideCustomerFieldFocusNode.requestFocus();
  }

  _getCustomersByCode(FindCustomerRequest request) {
    CustomerRepository().findCustomerByCode(request,
        onSuccess: _setCustomers,
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  _getSupplierByCode(FindCustomerRequest request) {
    CustomerRepository().findSupplierByCode(request,
        onSuccess: _setCustomers,
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  searchForInvoiceById(String id) async {
    isLoading(true);
    await InvoiceRepository().findInvPurchaseInvoiceBySerial(GetInvoiceRequest(serial: id, branchId: user.branchId, gallaryId: null),
        onSuccess: (data) {
          invoice(data);
          searchedItemInvoiceController.text = data.serial?.toString() ?? "";
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  newInvoice() {
    date(DateTime.now());
    selectedCustomer.value = null;
    invoice.value = null;
    notification.value = null;
    if(galleries.isNotEmpty) selectedGallery(galleries.first);
    searchedItemInvoiceController.clear();
    findSideCustomerController.clear();
    monawlaController.clear();
    remarksController.clear();
  }

  Future<void> getGalleries() {
    isLoading(true);
    return InvoiceRepository().getGalleries(
        GalleryRequest(branchId: user.branchId, id: user.id),
        onSuccess: (data) {
          galleries.assignAll(data);
          if(galleries.any((element) => element.id == user.galleryId)){
            selectedGallery(galleries.singleWhere((element) => element.id == user.galleryId));
          } else if (galleries.isNotEmpty) {
            selectedGallery(galleries.first);
          }
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false)
    );
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

  searchByNotification() {
    isLoading(true);
    final request =FindNotificationRequest(branchId: user.branchId, typeNotice: destinationType.value, serial: notificationNumberController.text.tryToParseToNum?.toInt()??0);
    NotificationsRepository().findInvoiceNotice(request,
        onSuccess: (data){
          notification(data);
          searchedItemInvoiceController.text = data.invInvoiceSerial?.toString()??"";
          findSideCustomerController.text = "${data.organizationSiteName} ${data.organizationSiteCode}";
          monawlaController.text = data.value?.toString()??"";
          remarksController.text = data.remark?.toString()??"";
          destinationType(data.typeNotice);
          if(galleries.any((element) => element.id == data.gallaryId)){
            selectedGallery(galleries.singleWhere((element) => element.id == data.gallaryId));
          }
        },
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }

  saveNotification(){
    final request = SaveNotificationRequest(
        serial: notification.value?.serial,
        typeNotice: destinationType.value,
        branchId: user.branchId,
        id: notification.value?.id,
        value: monawlaController.text.tryToParseToNum?.toDouble(),
        companyId: user.companyId,
        createdBy: user.id,
        createdDate: notification.value?.createdDate,
        date: date.value,
        invInvoice: notification.value?.invInvoice ?? invoice.value?.id,
        invInvoiceSerial: notification.value?.invInvoiceSerial ?? invoice.value?.serial,
        gallaryId: selectedGallery.value?.id,
        organizationSiteId: notification.value?.organizationSiteId ?? selectedCustomer.value?.id,
        remark: remarksController.text
    );
    isLoading(true);
    NotificationsRepository().saveInvoiceNotice(request,
        onSuccess: (data) {
          notification(data);
          showPopupText(text: "تم الحفظ بنجاح",type: MsgType.success);
        },
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }

  deleteNotification() {
    final request = DeleteNotificationRequest(notification.value!.id!);
    isLoading(true);
    NotificationsRepository().deleteInvoiceNotice(request,
        onSuccess: (_) {
          showPopupText(text: "تم الحذف بنجاح",type: MsgType.success);
        },
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }
}
