import 'package:get/get.dart';

import '../controllers/purchase_invoices_controller.dart';

class PurchaseInvoicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseInvoicesController>(
      () => PurchaseInvoicesController(),
    );
  }
}
