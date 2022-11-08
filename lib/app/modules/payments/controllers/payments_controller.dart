import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import 'package:toby_bills/app/data/model/invoice/dto/request/gl_account_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_response.dart';
import 'package:toby_bills/app/data/model/notifications/dto/response/find_notification_response.dart';
import 'package:toby_bills/app/data/model/payments/payment_model.dart';
import 'package:toby_bills/app/data/provider/local_provider.dart';
import 'package:toby_bills/app/data/repository/cost_center/cost_center_repository.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';

class PaymentsController extends GetxController {

  final isLoading = true.obs;
  final Rxn<FindCustomerResponse> selectedCustomer = Rxn();
  final Rx<DateTime> date = Rx(DateTime.now());
  final customers = <FindCustomerResponse>[];
  final accounts = <GlAccountResponse>[];
  final galleries = <GalleryResponse>[];
  final costCenters = <CostCenterResponse>[];
  final itemForm = GlobalKey<FormState>();
  Rxn<CostCenterResponse> selectedCenter = Rxn();
  Rxn<CostCenterResponse> selectedItemCenter = Rxn();
  Rxn<CostCenterResponse> itemSelectedCenter = Rxn();
  Rxn<GalleryResponse> selectedGallery = Rxn();
  Rxn<GlAccountResponse> selectedAccount = Rxn();
  Rxn<GlAccountResponse> selectedItemDebit = Rxn();
  Rxn<GlAccountResponse> selectedItemCredit = Rxn();
  Rxn<FindNotificationResponse> notification = Rxn();
  RxList<GlBankTransactionDetail> details = RxList();
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
  final itemDebitController = TextEditingController();
  final itemCreditController = TextEditingController();
  final itemCenterController = TextEditingController();
  final findSideCustomerFieldFocusNode = FocusNode();
  final searchedItemInvoiceFocusNode = FocusNode();
  final itemDebitFocusNode = FocusNode();
  final itemCreditFocusNode = FocusNode();
  final itemPriceFocusNode = FocusNode();
  final itemCommissionFocusNode = FocusNode();
  final itemCenterFocusNode = FocusNode();
  final itemRemarksFocusNode = FocusNode();
  InvoiceList? itemInvoice;

  @override
  void onInit() async {
    super.onInit();
    await getGlAccounts();
    await getGalleries();
    getCostCenters();
  }


  addDetail(){
    if(!itemForm.currentState!.validate()) return;
    final detial = GlBankTransactionDetail(
      value: itemPriceController.text.tryToParseToNum,
      remarks: itemRemarksController.text,
      createdDate: DateTime.now(),
      createdBy: user.id,
      glAccountDebitId: selectedItemDebit.value?.id,
      glAccountDebitName: selectedItemDebit.value?.name,
      glAccountCreditId: selectedItemCredit.value?.id,
      glAccountCreditName: selectedItemCredit.value?.name,
      companyId: user.companyId,
      invOrganizationSiteId: itemInvoice?.id,
    );
    details.add(detial);
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

  void getInvoiceListForCustomer(FindCustomerResponse value, void Function() onSuccess) {
    isLoading(true);
    CustomerRepository().findCustomerInvoicesData(
      FindCustomerBalanceRequest(id: value.id),
      onSuccess: (data) {
        findCustomerBalanceResponse = data;
        onSuccess();
      },
      onError: (error) => showPopupText(text: error.toString()),
      onComplete: () => isLoading(false),
    );
  }


  selectCustomer(FindCustomerResponse value){
    findSideCustomerController.text = "${value.name} ${value.code}";
    selectedCustomer(value);
    if(accounts.any((element) => element.id == value.accountIdApi)) {
      selectItemDebit(accounts.singleWhere((element) => element.id == value.accountIdApi),ignoreFocus: true);
    }
    if(selectedAccount.value != null) selectItemCredit(selectedAccount.value!,ignoreFocus: true);
    getInvoiceListForCustomer(value, () => searchedItemInvoiceFocusNode.requestFocus());
  }

  getCustomers(){
    isLoading(true);
    findSideCustomerFieldFocusNode.unfocus();
    final request = FindCustomerRequest(code: findSideCustomerController.text, branchId: user.branchId, gallaryIdAPI: selectedGallery.value?.id);
    // if(destinationType.value == 0) {
      _getCustomersByCode(request);
    // } else {
    //   _getSupplierByCode(request);
    // }
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

  selectInvoice(InvoiceList inv,{bool ignoreFocus = false}) async {
    searchedItemInvoiceController.text = inv.serial?.toString()??"";
    if(ignoreFocus) return;
    if(itemDebitController.text.isEmpty) {
      itemDebitFocusNode.requestFocus();
    } else if(itemCreditController.text.isEmpty) {
      itemCreditFocusNode.requestFocus();
    } else {
      itemPriceFocusNode.requestFocus();
    }
  }

  selectItemDebit(GlAccountResponse account,{bool ignoreFocus = false}){
    selectedItemDebit(account);
    itemDebitController.text = "${account.name} ${account.shotCode}";
    if(ignoreFocus) return;
    itemCreditFocusNode.requestFocus();
  }

  selectItemCredit(GlAccountResponse account,{bool ignoreFocus = false}){
    selectedItemCredit(account);
    itemCreditController.text = "${account.name} ${account.shotCode}";
    if(ignoreFocus) return;
    itemPriceFocusNode.requestFocus();
  }

  selectItemCenter(CostCenterResponse center,{bool ignoreFocus = false}){
    selectedItemCenter(center);
    itemCenterController.text = "${center.name}";
    if(ignoreFocus) return;
    itemRemarksFocusNode.requestFocus();
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

}
