import 'package:get/get.dart';

import '../controllers/polman_controller.dart';

class PolmanHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PolmanHomeController>(
      () => PolmanHomeController(),
    );
  }
}
