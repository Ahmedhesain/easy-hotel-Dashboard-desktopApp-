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
import 'package:toby_bills/app/data/model/invoice/dto/request/gl_account_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_response.dart';
import 'package:toby_bills/app/data/model/notifications/dto/response/find_notification_response.dart';
import 'package:toby_bills/app/data/model/payments/dto/request/delete_payment_request.dart';
import 'package:toby_bills/app/data/model/payments/dto/request/find_payment_request.dart';
import 'package:toby_bills/app/data/model/payments/payment_model.dart';
import 'package:toby_bills/app/data/provider/local_provider.dart';
import 'package:toby_bills/app/data/repository/cost_center/cost_center_repository.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/payment/payment_repository.dart';

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
  Rxn<PaymentModel> payment = Rxn();
  RxList<GlBankTransactionDetail> details = RxList();
  Map<int,FindCustomerBalanceResponse> findCustomerBalanceResponse = {};

  final user = UserManager();
  final itemInvoiceController = TextEditingController();
  final searchPaymentIdController = TextEditingController();
  final itemCustomerController = TextEditingController();
  final monawlaController = TextEditingController();
  final remarksController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemCommissionController = TextEditingController();
  final itemRemarksController = TextEditingController();
  final itemDebitController = TextEditingController();
  final itemCreditController = TextEditingController();
  final itemCenterController = TextEditingController();
  final itemCustomerFieldFocusNode = FocusNode();
  final itemInvoiceFocusNode = FocusNode();
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
    final detail = GlBankTransactionDetail(
      value: itemPriceController.text.tryToParseToNum,
      remarks: itemRemarksController.text,
      bankCommition: itemCommissionController.text.tryToParseToNum,
      createdDate: DateTime.now(),
      createdBy: user.id,
      glAccountDebitId: selectedItemDebit.value?.id,
      glAccountDebitName: selectedItemDebit.value?.name,
      glAccountDebitCode: selectedItemDebit.value?.accNumber,
      glAccountCreditId: selectedItemCredit.value?.id,
      glAccountCreditName: selectedItemCredit.value?.name,
      glAccountCreditCode: selectedItemCredit.value?.accNumber,
      companyId: user.companyId,
      invoiceId: itemInvoice?.id,
      invoiceSerial: itemInvoice?.serial,
      invOrganizationSiteId: selectedCustomer.value?.id,
      invOrganizationSiteCode: selectedCustomer.value?.code,
      invOrganizationSiteName: selectedCustomer.value?.name,
      costCenterId: selectedItemCenter.value?.id,
      costCenterCode: selectedItemCenter.value?.code,
      costCenterName: selectedItemCenter.value?.name,
    );
    details.add(detail);
    itemCustomerFieldFocusNode.requestFocus();
    clearItemFields();
  }

  newPayment(){
    remarksController.clear();
    monawlaController.clear();
    if(galleries.isNotEmpty) selectedGallery(galleries.first);
    selectedAccount.value = null;
    selectedCenter.value = null;
    details.clear();
    payment.value = null;
    date(DateTime.now());
    clearItemFields();
  }

  savePayment(){
    final payment = (this.payment.value??PaymentModel()).copyWith(
      glBankTransactionDetailFromApiList: details,
      companyId: this.payment.value?.companyId ?? user.companyId,
      createdBy: this.payment.value?.createdBy ?? user.id,
      createdDate: this.payment.value?.createdDate ?? DateTime.now(),
      branchId: this.payment.value?.branchId ?? user.branchId,
      remark: remarksController.text,
      date: DateTime.now(),
      totalValue: details.fold<num>(0, (p, e) => p + (e.value??0)),
      costCenterId: selectedCenter.value?.id,
      glAccountId: selectedAccount.value?.id
    );
    isLoading(true);
    PaymentRepository().savePayment(payment,
      onSuccess: (data){
        this.payment(data);
        showPopupText(text: "تم الحفظ بنجاح",type: MsgType.success);
      },
      onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false)
    );
  }

  searchPayment(){
    isLoading(true);
    PaymentRepository().findPayment(FindPaymentRequest(branchId: user.branchId, serial: searchPaymentIdController.text.tryToParseToNum?.toInt()),
        onSuccess: (data){
          payment(data);
          details.assignAll(data.glBankTransactionDetailFromApiList!);
          date(data.date);
          remarksController.text = data.remark??"";
        },
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false)
    );

  }

  printPayment(){
  }

  deletePayment(){
    isLoading(true);
    PaymentRepository().deletePayment(DeletePaymentRequest(id: payment.value!.id!),
        onSuccess: (data){
          showPopupText(text: "تم الحذف بنجاح",type: MsgType.success);
        },
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false)
    );

  }

  clearItemFields(){
    itemPriceController.clear();
    itemRemarksController.clear();
    itemCommissionController.clear();
    itemCustomerController.clear();
    itemInvoiceController.clear();
    itemDebitController.clear();
    itemCreditController.clear();
    itemCenterController.clear();
    selectedItemDebit.value = null;
    selectedItemCredit.value = null;
    itemInvoice = null;
    selectedCustomer.value = null;
    selectedItemCenter.value = null;
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
        findCustomerBalanceResponse[value.id!] = data;
        onSuccess();
      },
      onError: (error) => showPopupText(text: error.toString()),
      onComplete: () => isLoading(false),
    );
  }


  selectCustomer(FindCustomerResponse value){
    itemCustomerController.text = "${value.name} ${value.code}";
    selectedCustomer(value);
    if(accounts.any((element) => element.id == value.accountIdApi)) {
      selectItemDebit(accounts.singleWhere((element) => element.id == value.accountIdApi),ignoreFocus: true);
    }
    if(selectedAccount.value != null) selectItemCredit(selectedAccount.value!,ignoreFocus: true);
    getInvoiceListForCustomer(value, () => itemInvoiceFocusNode.requestFocus());
  }

  Future<void> getCustomers(String search) async {
    isLoading(true);
    itemCustomerFieldFocusNode.unfocus();
    final request = FindCustomerRequest(code: search, branchId: user.branchId, gallaryIdAPI: selectedGallery.value?.id);
    await CustomerRepository().findCustomerByCode(request,
        onSuccess: customers.assignAll,
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }


  selectInvoice(InvoiceList inv,{bool ignoreFocus = false}) async {
    itemInvoiceController.text = inv.serial?.toString()??"";
    itemInvoice = inv;
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
    itemDebitController.text = "${account.name} ${account.accNumber}";
    if(ignoreFocus) return;
    itemCreditFocusNode.requestFocus();
  }

  selectItemCredit(GlAccountResponse account,{bool ignoreFocus = false}){
    selectedItemCredit(account);
    itemCreditController.text = "${account.name} ${account.accNumber}";
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
