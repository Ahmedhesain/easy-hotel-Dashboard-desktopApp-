import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/find_invoices_query_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';

class InvoicesQueryController extends GetxController {

  final List<InvoiceModel> invoices = [];
  final isLoading = false.obs;
  DateTime dateFrom = DateTime.now();
  DateTime dateTo = DateTime.now();
  final searchCustomerFocusNode = FocusNode();
  final searchedInvoiceController = TextEditingController();

  getInvoices() async {
    if(searchedInvoiceController.text.isEmpty){
      showPopupText(text: "يرجى كتابة رقم فاتورة اولاً", type: MsgType.error);
      return;
    }
    final request = FindInvoicesQueryRequest(gallaryId: UserManager().galleryId, searchNumber: searchedInvoiceController.text);
    isLoading(true);
    InvoiceRepository().findInvoicesQuery(request,
      onSuccess: invoices.assignAll,
      onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false)
    );
  }


}
