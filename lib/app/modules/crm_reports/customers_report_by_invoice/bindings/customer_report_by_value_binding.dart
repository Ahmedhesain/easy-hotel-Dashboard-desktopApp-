



import 'package:get/get.dart';

import '../controllers/customer_report_by_invoice_controller.dart';

class CustomersReportByInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomersReportByInvoiceController>(() => CustomersReportByInvoiceController());
  }

}