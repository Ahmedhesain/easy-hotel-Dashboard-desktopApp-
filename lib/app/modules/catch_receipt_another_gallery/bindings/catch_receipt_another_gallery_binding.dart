import 'package:get/get.dart';

import '../controllers/catch_receipt_another_gallery_controller.dart';

class CatchReceiptAnotherGalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CatchReceiptAnotherGalleryController>(
      () => CatchReceiptAnotherGalleryController(),
    );
  }
}
