import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/find_invoices_query_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';

class InvoicesQueryController extends GetxController {

  final  invoices = <InvoiceModel>[].obs;
  final isLoading = false.obs;
  final dateFrom = DateTime.now().obs;
  final dateTo = DateTime.now().obs;
  final searchCustomerFocusNode = FocusNode();
  final searchedInvoiceController = TextEditingController();
  final searchType = 0.obs ;

  getInvoices() async {
    if(searchedInvoiceController.text.isEmpty){
      showPopupText(text: "يرجى كتابة رقم فاتورة اولاً", type: MsgType.error);
      return;
    }
    invoices.clear() ;
    final request = FindInvoicesQueryRequest(
        gallaryId: UserManager().galleryId,
        searchNumber: searchedInvoiceController.text,
        dateFrom: dateFrom.value,
        dateTo: dateTo.value,
       searchType: searchType.value
    );
    isLoading(true);
    InvoiceRepository().findInvoicesQuery(request,
      onSuccess: (data){
        invoices.assignAll(data);
        invoices.refresh();
      } ,
      onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false)
    );
  }


}
