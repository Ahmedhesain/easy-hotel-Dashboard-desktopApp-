import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/cost_center/dto/request/get_cost_center_request.dart';
import 'package:toby_bills/app/data/model/cost_center/dto/response/cost_center_response.dart';
import 'package:toby_bills/app/data/model/general_journal/dto/request/account_summary_request.dart';
import 'package:toby_bills/app/data/model/general_journal/dto/response/account_summary_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/gl_account_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';
import 'package:toby_bills/app/data/provider/local_provider.dart';
import 'package:toby_bills/app/data/repository/cost_center/cost_center_repository.dart';
import 'package:toby_bills/app/data/repository/general_journal/general_journal_repository.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';

class SubAccountStatementController extends GetxController {
  final isLoading = false.obs;
  final Rxn<DateTime> dateFrom = Rxn();
  final Rxn<DateTime> dateTo = Rxn();
  final accounts = <GlAccountResponse>[];
  final costCenters = <CostCenterResponse>[];
  final statements = <AccountSummaryResponse>[];
  final Rxn<CostCenterResponse> selectedCenterFrom = Rxn();
  final Rxn<CostCenterResponse> selectedCenterTo = Rxn();
  final userManager = UserManager();
  final Rxn<GlAccountResponse> selectedAccount = Rxn();

  @override
  void onInit() {
    super.onInit();
    getAccounts();
    getCostCenters();
  }

  pickFromDate() async {
    dateFrom(await _pickDate(initialDate: dateFrom.value ?? DateTime.now(), firstDate: DateTime(2017), lastDate: dateTo.value ?? DateTime.now()));
  }

  pickToDate() async {
    dateTo(await _pickDate(initialDate: dateTo.value ?? DateTime.now(), firstDate: dateFrom.value ?? DateTime.now(), lastDate: DateTime.now()));
  }

  _pickDate({required DateTime initialDate, required DateTime firstDate, required DateTime lastDate}) {
    return showDatePicker(context: Get.overlayContext!, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate);
  }

  getStatements(){
    final request = AccountSummaryRequest(
      branchId: userManager.branchId,
      dateFrom: dateFrom.value,
      dateTo: dateTo.value,
      costCenterFrom: selectedCenterFrom.value?.id,
      costCenterTo: selectedCenterTo.value?.id,
      glaccountId: selectedAccount.value?.id
    );
    isLoading(true);
    GeneralJournalRepository().getAccountSummary(request,
      onSuccess: statements.assignAll,
      onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false)
    );
  }

  getAccounts() {
    accounts.assignAll(LocalProvider().getGlAccounts());
    if (accounts.isNotEmpty) return;
    isLoading(true);
    InvoiceRepository().getGlAccountList(GlAccountRequest(userManager.branchId),
        onSuccess: (data) {
          LocalProvider().saveGlAccounts(data);
          accounts.assignAll(data);
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  Future<void> getCostCenters() {
    isLoading(true);
    return CostCenterRepository().getAll(GetCostCenterRequest(branchId: userManager.branchId),
        onSuccess: (data) {
          costCenters.assignAll(data);
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }
}
