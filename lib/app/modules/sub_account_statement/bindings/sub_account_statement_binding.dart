import 'package:get/get.dart';

import '../controllers/sub_account_statement_controller.dart';

class SubAccountStatementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubAccountStatementController>(
      () => SubAccountStatementController(),
    );
  }
}
