import 'package:get/get.dart';

import '../controllers/spa_controller.dart';

class SpaHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpaHomeController>(
      () => SpaHomeController(),
    );
  }
}
