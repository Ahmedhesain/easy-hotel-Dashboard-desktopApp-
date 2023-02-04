import 'package:get/get.dart';

import '../controllers/catch_receipt_another_gallery_new_controller.dart';

class CatchReceiptAnotherGalleryNewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CatchReceiptAnotherGalleryNewController>(
      () => CatchReceiptAnotherGalleryNewController(),
    );
  }
}
