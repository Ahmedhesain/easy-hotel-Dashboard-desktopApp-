import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/find_invoice_data_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';

class InvoiceReceiveController extends GetxController {


  final searchController = TextEditingController();
  final remarksController = TextEditingController();
  final searchFocus = FocusNode();
  final notesFocus = FocusNode();
  final isLoading = false.obs;
  Rxn<InvoiceModel> invoiceModel = Rxn();
  final userManager = UserManager();
  bool isSaved = false;

  search() async {
    final request = FindInvoiceDataRequest(branchId: userManager.branchId, invSerial: searchController.text);
    isLoading(true);
    InvoiceRepository().findReceiveInvoiceData(request,
        onSuccess: (data){
          invoiceModel(data);
          notesFocus.requestFocus();
        },
        onError: (error) => showPopupText(text: error, type: MsgType.error),
        onComplete: () => isLoading(false)
    );
  }

  save(BuildContext context) async {
    if(invoiceModel.value == null){
      showPopupText(text: "يرجى اختيار فاتورة اولاً", type: MsgType.error);
      return;
    }
    if(invoiceModel.value!.invoiceDetailApiList?.isEmpty??true){
      showPopupText(text: "لا يمكن حفظ فاتورة لاتحوي تفاصيل", type: MsgType.error);
      return;
    }
    isLoading(true);
    invoiceModel.value!.remarks = remarksController.text;
    invoiceModel.value!.branchId  =userManager.branchId;
    invoiceModel.value!.gallaryId =userManager.galleryId;
    invoiceModel.value!.companyId =userManager.companyId;
    invoiceModel.value!.createdBy =userManager.id;
    invoiceModel.value!.date =DateTime.now();
    await InvoiceRepository().saveReceiveInvoice(
        invoiceModel.value!,
        onSuccess: (data) {
          invoiceModel.value!.serial = data.serial;
          isSaved = true;
          newOne();
        },
        onError: (error) {
          showPopupText(text: error, type: MsgType.error);
          invoiceModel.value = null;
        },
        onComplete: () => isLoading(false)
    );
  }

  newOne() {
    invoiceModel.value = null;
    isSaved = false;
    remarksController.clear();
    searchController.clear();
  }


}
