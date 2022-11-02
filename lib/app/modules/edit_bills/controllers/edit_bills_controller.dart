import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/account_statement_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/account_statement_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/edit_bills_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/edit_bills_response.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

import '../../../core/utils/show_popup_text.dart';

class EditBillsController extends GetxController {


  final List<EditBillsResponse> reports = [];
  final isLoading = true.obs;
  final dateFrom = DateTime.now().obs;
  final dateTo = DateTime.now().obs;
  final manager = UserManager();
  final selectedStatus = TextEditingController().obs;




  @override
  void onInit() {
    super.onInit();
    getStatements();
  }

  getStatements() async {
    isLoading(true);
    final request = EditBillsRequest(serial: 166242,branchId: manager.branchId,dateFrom:dateFrom.value,dateTo: dateTo.value);
    ReportsRepository().getEditBillsStatement(request,
        onSuccess: (data) => reports.assignAll(data),
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


}
