import 'package:get/get.dart';

import '../controllers/edit_bills_controller.dart';

class EditBillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditBillsController>(
      () => EditBillsController(),
    );
  }
}
