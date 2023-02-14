import 'package:get/get.dart';

import '../controllers/rooms_controller.dart';

class RoomsHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoomsHomeController>(
      () => RoomsHomeController(),
    );
  }
}
