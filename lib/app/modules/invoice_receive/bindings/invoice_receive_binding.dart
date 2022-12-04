import 'package:get/get.dart';

import '../controllers/invoice_receive_controller.dart';

class InvoiceReceiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceReceiveController>(
      () => InvoiceReceiveController(),
    );
  }
}
