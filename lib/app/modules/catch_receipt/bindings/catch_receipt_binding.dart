import 'package:get/get.dart';

import '../controllers/catch_receipt_controller.dart';

class CatchReceiptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CatchReceiptController>(
      () => CatchReceiptController(),
    );
  }
}
