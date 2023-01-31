

import 'package:get/get.dart';

import '../controllers/customer_comparison_controller.dart';

class CustomerComparisonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerComparisonController>(() => CustomerComparisonController());
  }

}