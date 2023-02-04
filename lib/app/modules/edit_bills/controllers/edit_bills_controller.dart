import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_balance_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
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

  final reports = <GlPayDTO>[].obs;
  final isLoading = false.obs;
  final Rxn<DateTime> dateFrom = Rxn();
  final Rxn<DateTime> dateTo = Rxn();
  final Rxn<DateTime> editDate = Rxn();
  InvoiceList? itemInvoice;

  final manager = UserManager();
  final selectedStatusController = TextEditingController();
  final findSideCustomerController = TextEditingController();
  final invoiceCustomerController = TextEditingController();
  final user = UserManager();
  Map<int,FindCustomerBalanceResponse> balances = {};
  final customers = <FindCustomerResponse>[];
  final banks = <GlPayDTO>[];


  @override
  void onInit() {
    super.onInit();
    getAllBanks() ;
  }

  getStatements() async {
    isLoading(true);
    final request = EditBillsRequest(
        serial:int.tryParse(selectedStatusController.text),
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

  getCustomersByCodeForInvoice(String code, FocusNode node, int reportId) {
    final request = FindCustomerRequest(code: code, branchId: UserManager().branchId, gallaryIdAPI: reports.singleWhere((element) => element.id == reportId).gallaryId);
    isLoading(true);
    node.unfocus();
    CustomerRepository().findCustomerByCode(request,
        onSuccess: (data) {
          customers.assignAll(data);
          node.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  getAllBanks() {
    isLoading(true);
    final request = AllInvoicesRequest(id: UserManager().id, branchId: UserManager().branchId);
    ReportsRepository().getAllGlPay(request,
        onSuccess: (data) {
          banks.assignAll(data);
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

  void getInvoiceListForCustomer(int id, void Function() onSuccess) {
    if(balances.containsKey(id)) return;
    isLoading(true);
    CustomerRepository().findCustomerInvoicesData(
      FindCustomerBalanceRequest(id: id),
      onSuccess: (data) {
        balances[id] = (data);
        onSuccess();
      },
      onError: (error) => showPopupText(text: error.toString()),
      onComplete: () => isLoading(false),
    );
  }

  editInvoice(GlPayDTO dto) {
    if(balances[dto.customerId] != null && (balances[dto.customerId]?.invoicesList.every((element) => element.serial != dto.invoiceSerial)??false)){
      showPopupText(text: "رقم الفاتورة غير صحيح");
      return;
    }
    final request = GlBankTransactionApi(glPayDTOAPIList:[dto], branchId: user.branchId, createdBy: user.id, companyId: user.companyId, customerId: dto.customerId,remark: dto.remark, date: dto.date );
    isLoading(true);
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
