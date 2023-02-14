import 'package:get/get.dart';

import '../controllers/halls_controller.dart';

class HallsHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HallsHomeController>(
      () => HallsHomeController(),
    );
  }
}
