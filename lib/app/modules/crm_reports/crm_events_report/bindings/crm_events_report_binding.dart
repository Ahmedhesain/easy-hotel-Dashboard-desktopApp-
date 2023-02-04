


import 'package:get/get.dart';

import '../controllers/crm_events_report_controller.dart';

class CrmEventsReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrmEventsReportController>(() => CrmEventsReportController());
  }

}