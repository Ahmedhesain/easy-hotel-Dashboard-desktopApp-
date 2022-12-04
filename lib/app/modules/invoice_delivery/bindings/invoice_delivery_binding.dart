import 'package:get/get.dart';

import '../controllers/invoice_delivery_controller.dart';

class InvoiceDeliveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceDeliveryController>(
      () => InvoiceDeliveryController(),
    );
  }
}
