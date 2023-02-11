


import 'package:get/get.dart';
import '../controllers/daily_attach_search_controller.dart';

class DailyAttachSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DailyAttachSearchController>(() => DailyAttachSearchController());
  }

}