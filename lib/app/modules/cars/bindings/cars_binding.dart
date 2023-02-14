import 'package:get/get.dart';

import '../controllers/cars_controller.dart';

class CarsHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarsHomeController>(
      () => CarsHomeController(),
    );
  }
}
