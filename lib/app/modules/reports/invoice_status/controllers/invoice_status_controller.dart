import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/invoice_status_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_status_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

class InvoiceStatusController extends GetxController {

    final List<InvoiceStatusResponse> reports = [];
    final isLoading = true.obs;
    TextEditingController searchedInvoiceController = TextEditingController();

    @override
    void onInit() {
      super.onInit();
      getStatements();
    }

    getStatements() async {
      isLoading(true);
      final homeSerial = Get.find<HomeController>().invoice.value!.serial;
       int? reportSerial = int.tryParse(searchedInvoiceController.text);
      final request = InvoiceStatusRequest(serial:reportSerial  ?? homeSerial, branchId: UserManager().branchId, gallaryId: UserManager().galleryId);
      InvoiceRepository().getInvoiceStatus(request,
        onSuccess: (data) => reports.assignAll(data),
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false)
      );
    }

}
