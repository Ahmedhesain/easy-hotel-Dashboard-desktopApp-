import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/edit_bills_request.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';
import '../../../core/utils/show_popup_text.dart';

class EditBillsController extends GetxController {

  final List<GlPayDTO> reports = [];
  final isLoading = false.obs;
  final Rx<DateTime> dateFrom = Rx(DateTime.now().subtract(const Duration(days: 1)));
  final Rx<DateTime> dateTo = Rx(DateTime.now());
  final Rxn<DateTime> editDate = Rxn();

  final manager = UserManager();
  final selectedStatusController = TextEditingController();
  final findSideCustomerController = TextEditingController();
  final invoiceCustomerController = TextEditingController();

  final customers = <FindCustomerResponse>[];
  final allInvoices = <GlPayDTO>[];
  final allInvoicesSelected = <GlPayDTO>[];


  @override
  void onInit() {
    super.onInit();
    getAllInvoices() ;
  }

  getStatements() async {
    if(int.tryParse(selectedStatusController.text) == null) return;
    isLoading(true);
    final request = EditBillsRequest(
        serial:int.parse(selectedStatusController.text),
        branchId: manager.branchId,
        dateFrom:dateFrom.value,
        dateTo: dateTo.value,
    );
    ReportsRepository().getEditBillsStatement(request,
        onSuccess: reports.assignAll,
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }

  pickFromDate() async {
    dateFrom(await _pickDate(initialDate: dateFrom.value, firstDate: DateTime(2019), lastDate: dateTo.value));
  }

  pickToDate() async {
    dateTo(await _pickDate(initialDate: dateTo.value, firstDate: dateFrom.value, lastDate: DateTime.now()));
  }

  pickEditDate(DateTime date) async {
    editDate(await _pickDate(initialDate: date, firstDate: date , lastDate: DateTime.now()));
  }

  _pickDate({required DateTime initialDate, required DateTime firstDate, required DateTime lastDate}) {
    return showDatePicker(context: Get.overlayContext!, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate);
  }

  getCustomersByCode() {
    isLoading(true);
    final request = FindCustomerRequest(code: findSideCustomerController.text, branchId: UserManager().branchId, gallaryIdAPI: UserManager().galleryId);
    CustomerRepository().findCustomerByCode(request,
        onSuccess: (data) {
          customers.assignAll(data);
          // findSideCustomerFieldFocusNode.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  getCustomersByCodeForInvoice(String code, FocusNode node) {
    isLoading(true);
    node.unfocus();
    final request = FindCustomerRequest(code: code, branchId: UserManager().branchId, gallaryIdAPI: UserManager().galleryId);
    CustomerRepository().findCustomerByCode(request,
        onSuccess: (data) {
          customers.assignAll(data);
          node.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  addinvoice(GlPayDTO? ivoiceSelected) {
    allInvoicesSelected.add(ivoiceSelected!);
  }

  getAllInvoices() {
    isLoading(true);
    final request = AllInvoicesRequest(id: UserManager().id, branchId: UserManager().branchId);
    ReportsRepository().getAllInvoicesStatement(request,
        onSuccess: (data) {
          allInvoices.assignAll(data);
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  editInvoice(List<GlPayDTO> bankSelected,int customerSelected) {
    isLoading(true);
    // findSideCustomerFieldFocusNode.unfocus();
    final request = GlBankTransactionApi(glPayDTOAPIList:bankSelected, remark: "ddffd" ,branchId: UserManager().branchId,customerId:customerSelected,createdBy: UserManager().id,companyId: UserManager().companyId );
    ReportsRepository().editInvoicesStatement(request,
        onSuccess: (data) {
          // customers.assignAll(data);
          // findSideCustomerFieldFocusNode.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

}
