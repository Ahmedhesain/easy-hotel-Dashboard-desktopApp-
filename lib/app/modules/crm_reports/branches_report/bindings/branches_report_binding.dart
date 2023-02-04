

import 'package:get/get.dart';

import '../controllers/branches_report_controller.dart';

class BranchesReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BranchesReportController>(() => BranchesReportController());
  }

}