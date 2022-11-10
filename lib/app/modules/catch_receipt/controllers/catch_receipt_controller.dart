import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';
import 'package:toby_bills/app/core/extensions/string_ext.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_balance_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/edit_bills_request.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';

import '../../../data/model/customer/dto/response/find_customer_response.dart';

class CatchReceiptController extends GetxController {
  final isLoading = false.obs;
  final customers = <FindCustomerResponse>[];
  final banks = <GlPayDTO>[];
  final banksToPay = <GlPayDTO>[].obs;
  final user = UserManager();
  final customerFocusNode = FocusNode();
  final customerController = TextEditingController();
  final remarksController = TextEditingController();
  final itemInvoiceController = TextEditingController();
  final itemRemainController = TextEditingController();
  final itemPayController = TextEditingController();
  final itemBankController = TextEditingController();
  final itemInvoiceFocus = FocusNode();
  final itemRemainFocus = FocusNode();
  final itemPayFocus = FocusNode();
  final itemBankFocus = FocusNode();
  InvoiceList? itemInvoice;
  GlPayDTO? itemBank;
  Rxn<FindCustomerResponse> selectedCustomer = Rxn();
  Rxn<GlBankTransactionApi> glBankTransactionApi = Rxn();
  Rxn<FindCustomerBalanceResponse> customerBalance = Rxn();

  @override
  onInit(){
    super.onInit();
    getBanks();
  }

  Future<void> getCustomers(String search) async {
    isLoading(true);
    customerFocusNode.unfocus();
    final request = FindCustomerRequest(code: search, branchId: user.branchId, gallaryIdAPI: user.galleryId);
    await CustomerRepository().findCustomerByCode(request,
        onSuccess: (data) {
          customers.assignAll(data);
          customerFocusNode.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  getBanks() {
    isLoading(true);
    final request = AllInvoicesRequest(id: user.id, branchId: user.branchId);
    ReportsRepository().getAllBanks(request,
        onSuccess: (data) {
          banks.assignAll(data);
          if(banks.isNotEmpty) {
            itemBank = banks.first;
            itemBankController.text = itemBank!.bankName ?? "";
          }
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  void getInvoiceListForCustomer(FindCustomerResponse value, void Function() onSuccess) {
    isLoading(true);
    CustomerRepository().findCustomerInvoicesData(
      FindCustomerBalanceRequest(id: value.id),
      onSuccess: (data) {
        customerBalance(data);
        onSuccess();
      },
      onError: (error) => showPopupText(text: error.toString()),
      onComplete: () => isLoading(false),
    );
  }

  void addNewDetail() {
    banksToPay.add(GlPayDTO(
      bankName: itemBank!.bankName,
      bankId: itemBank!.id,
      remain: itemRemainController.text.tryToParseToNum,
      value: itemPayController.text.tryToParseToNum,
      invoiceId: itemInvoice!.id,
      invoiceSerial: itemInvoice!.serial,
    ));
    clearItemFields();
    itemInvoiceFocus.requestFocus();
  }

  save(){
    final request = GlBankTransactionApi(
      customerId: selectedCustomer.value?.id,
      remark: remarksController.text,
      date: DateTime.now(),
      createdBy: user.id,
      companyId: user.companyId,
      branchId: user.branchId,
      customerBalance: customerBalance.value?.balance,
      customerName: selectedCustomer.value?.name,
      glPayDTOAPIList: banksToPay
    );
    isLoading(true);
    ReportsRepository().saveInvoicesStatement(request,
      onSuccess: (data){
        showPopupText(text: "تم حفظ السند ينجاح", type: MsgType.success);
        newPay();
      },
      onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false)
    );
  }

  newPay(){
    selectedCustomer.value = null;
    customerBalance.value = null;
    customerController.clear();
    remarksController.clear();
    banksToPay.clear();
    clearItemFields();
  }

  clearItemFields(){
    itemInvoice = null;
    if(banks.isNotEmpty) {
      itemBank = banks.first;
      itemBankController.text = itemBank!.bankName ?? "";
    }
    itemInvoiceController.clear();
    itemPayController.clear();
    itemRemainController.clear();
  }

}
