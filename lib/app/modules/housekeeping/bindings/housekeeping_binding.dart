import 'package:get/get.dart';

import '../controllers/housekeeping_controller.dart';

class HousekeepingHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HousekeepingHomeController>(
      () => HousekeepingHomeController(),
    );
  }
}
