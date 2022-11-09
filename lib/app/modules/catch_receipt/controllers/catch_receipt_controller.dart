import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_balance_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/edit_bills_request.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';

import '../../../data/model/customer/dto/response/find_customer_response.dart';

class CatchReceiptController extends GetxController {

  final isLoading = false.obs;
  final customers = <FindCustomerResponse>[];
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

  Rxn<FindCustomerResponse> selectedCustomer = Rxn();
  Rxn<GlBankTransactionApi> glBankTransactionApi = Rxn();
  Rxn<FindCustomerBalanceResponse> customerBalance = Rxn();

  Future<void> getCustomers(String search) async {
    isLoading(true);
    customerFocusNode.unfocus();
    final request = FindCustomerRequest(code: search, branchId: user.branchId, gallaryIdAPI: user.galleryId);
    await CustomerRepository().findCustomerByCode(request,
        onSuccess: (data){
          customers.assignAll(data);
          customerFocusNode.requestFocus();
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


}
