import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/extensions/string_ext.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/account_statement_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/account_statement_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/edit_bills_request.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

import '../../../core/utils/show_popup_text.dart';

class EditBillsController extends GetxController {


  final List<GlPayDTO> reports = [];
  final isLoading = false.obs;
  final dateFrom = DateTime.now().obs;
  final dateTo = DateTime.now().obs;
  final manager = UserManager();
  final selectedStatus = TextEditingController();
  List<TextEditingController> fieldsControllers=[];
  final findSideCustomerController = TextEditingController();
  final invoiceCustomerController = TextEditingController();
  List <FocusNode> nodes = [];


  final customers = <FindCustomerResponse>[];
  final allInvoices = <GlPayDTO>[];

  final allInvoicesSelected = <GlPayDTO>[];






  @override
  void onInit() {
    super.onInit();
    getAllInvoices() ;
  }

  TextEditingController reportController(GlPayDTO report){
    final index = reports.indexWhere((e)=>e.id == report.id);
    return fieldsControllers[index];
  }
  FocusNode reportNodes(GlPayDTO report){
    final index = reports.indexWhere((e)=>e.id == report.id);
    return nodes[index];
  }
  TextEditingController bankController(GlPayDTO report){
    final index = reports.indexWhere((e)=>e.id == report.id);
    return fieldsControllers[index];
  }
  FocusNode bankNodes(GlPayDTO report){
    final index = reports.indexWhere((e)=>e.id == report.id);
    return nodes[index];
  }
  getStatements() async {
    if(int.tryParse(selectedStatus.text) == null) return;
    isLoading(true);
    final request = EditBillsRequest(serial:int.parse(selectedStatus.text) ,branchId: manager.branchId,dateFrom:null,dateTo: null);
    ReportsRepository().getEditBillsStatement(request,
        onSuccess: (data) {
          reports.assignAll(data);
          fieldsControllers.assignAll(List.generate(reports.length, (index) => TextEditingController(text: reports[index].customerName??"")));
          nodes.assignAll(List.generate(reports.length, (index) => FocusNode()));
        },
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

  _pickDate({required DateTime initialDate, required DateTime firstDate, required DateTime lastDate}) {
    return showDatePicker(context: Get.overlayContext!, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate);
  }
  getCustomersByCode() {
    isLoading(true);
    // findSideCustomerFieldFocusNode.unfocus();
    final request = FindCustomerRequest(code: findSideCustomerController.text, branchId: UserManager().branchId, gallaryIdAPI: UserManager().galleryId);
    CustomerRepository().findCustomerByCode(request,
        onSuccess: (data) {
          customers.assignAll(data);
          // findSideCustomerFieldFocusNode.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  getCustomersByCodeForInvoice(FocusNode node) {
    isLoading(true);
    node.unfocus();
    final request = FindCustomerRequest(code: invoiceCustomerController.text, branchId: UserManager().branchId, gallaryIdAPI: UserManager().galleryId);
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
