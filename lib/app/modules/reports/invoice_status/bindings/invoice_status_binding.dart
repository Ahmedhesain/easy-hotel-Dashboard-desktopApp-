import 'package:get/get.dart';

import '../controllers/invoice_status_controller.dart';

class InvoiceStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceStatusController>(
      () => InvoiceStatusController(),
    );
  }
}
