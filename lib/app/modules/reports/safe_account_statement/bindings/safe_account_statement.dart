import 'package:get/get.dart';
import 'package:toby_bills/app/modules/reports/items_quantity/controllers/items_quantity_controller.dart';
import 'package:toby_bills/app/modules/reports/safe_account_statement/controllers/safe_account_statement_controller.dart';

class SafeAccountStatementBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<SafeAccountStatementController>(() => SafeAccountStatementController());
  }

}
