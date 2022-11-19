import 'package:get/get.dart';

import '../controllers/faseh_details_controller.dart';

class FasehDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FasehDetailsController>(
      () => FasehDetailsController(),
    );
  }
}
