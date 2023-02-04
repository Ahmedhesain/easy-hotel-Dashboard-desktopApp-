


import 'package:get/get.dart';

import '../controller/crm_event_controller.dart';

class CrmEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrmEventController>(() => CrmEventController());
  }

}