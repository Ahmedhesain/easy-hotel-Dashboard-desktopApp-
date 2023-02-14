import 'package:get/get.dart';

import '../controllers/restraunt_controller.dart';

class RestrauntHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestrauntHomeController>(
      () => RestrauntHomeController(),
    );
  }
}
