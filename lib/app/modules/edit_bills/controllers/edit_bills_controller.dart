import 'dart:ffi';

import 'package:get/get.dart';
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


  @override
  void onInit() {
    super.onInit();
    getStatements();
  }

  getStatements() async {
    isLoading(true);
    final request = EditBillsRequest(serial: 166243,branchId: 182,dateFrom: DateTime.now(),dateTo: DateTime.now());
    ReportsRepository().getEditBillsStatement(request,
        onSuccess: (data) => reports.assignAll(data),
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }


}
