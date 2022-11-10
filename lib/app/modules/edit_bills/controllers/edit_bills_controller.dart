import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/payments/dto/request/delete_payment_request.dart';
import 'package:toby_bills/app/data/model/payments/dto/request/find_payment_request.dart';
import 'package:toby_bills/app/data/model/payments/payment_model.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/edit_bills_request.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';
import 'package:toby_bills/app/data/repository/payment/payment_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';
import '../../../core/utils/show_popup_text.dart';

class EditBillsController extends GetxController {

  final List<GlPayDTO> reports = [];
  final isLoading = false.obs;
  final Rxn<DateTime> dateFrom = Rxn();
  final Rxn<DateTime> dateTo = Rxn();
  final Rxn<DateTime> editDate = Rxn();

  final manager = UserManager();
  final selectedStatusController = TextEditingController();
  final findSideCustomerController = TextEditingController();
  final invoiceCustomerController = TextEditingController();
  final user = UserManager();
  final customers = <FindCustomerResponse>[];
  final allInvoices = <GlPayDTO>[];


  @override
  void onInit() {
    super.onInit();
    getAllInvoices() ;
  }

  getStatements() async {
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
    dateFrom(await _pickDate(initialDate: dateFrom.value??DateTime.now(), firstDate: DateTime(2017), lastDate: dateTo.value??DateTime.now()));
  }

  pickToDate() async {
    dateTo(await _pickDate(initialDate: dateTo.value??DateTime.now(), firstDate: dateFrom.value??DateTime.now(), lastDate: DateTime.now()));
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

  getAllInvoices() {
    isLoading(true);
    final request = AllInvoicesRequest(id: UserManager().id, branchId: UserManager().branchId);
    ReportsRepository().getAllBanks(request,
        onSuccess: (data) {
          allInvoices.assignAll(data);
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  deleteRow(int id) {
    isLoading(true);
    final request = DeletePaymentRequest(id: id);
    PaymentRepository().deletePayment(request,
        onSuccess: (data) {
          showPopupText(text: 'تم الحذف بنجاح', type: MsgType.success);
          reports.removeWhere((element) => element.id == id);
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }



  editInvoice(GlPayDTO bankSelected) {
    isLoading(true);
    final request = GlBankTransactionApi(glPayDTOAPIList:[bankSelected], branchId: user.branchId, createdBy: user.id, companyId: user.companyId );
    ReportsRepository().saveInvoicesStatement(request,
        onSuccess: (data) {
          showPopupText(text: "تم التعديل بنجاح", type: MsgType.success);
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  printRow(int id, BuildContext context) {
    isLoading(true);
    final request = FindPaymentRequest(id: id, branchId: user.branchId);
    PaymentRepository().findPaymentById(request,
        onSuccess: (data) {
          final receipt = GlBankTransactionApi(
            glPayDTOAPIList: [data],
            customerName: data.customerName,
            date: data.date,
            remark: data.remark
          );
          PrintingHelper().printReceipt(context, receipt);
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));

  }

}
