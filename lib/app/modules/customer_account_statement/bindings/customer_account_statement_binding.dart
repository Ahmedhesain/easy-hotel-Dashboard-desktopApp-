import 'package:get/get.dart';

import '../controllers/customer_account_statement_controller.dart';

class CustomerAccountStatementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerAccountStatementController>(
      () => CustomerAccountStatementController(),
    );
  }
}
