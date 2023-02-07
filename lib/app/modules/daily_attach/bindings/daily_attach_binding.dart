


import 'package:get/get.dart';

import '../controllers/daily_attach_controller.dart';

class DailyAttachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DailyAttachController>(() => DailyAttachController());
  }

}