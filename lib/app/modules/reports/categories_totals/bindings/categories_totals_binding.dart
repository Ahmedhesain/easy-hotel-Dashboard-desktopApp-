import 'package:get/get.dart';

import '../controllers/categories_totals_controller.dart';

class CategoriesTotalsBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<CategoriesTotalsController>(
      () => CategoriesTotalsController(),
    );
  }

}
