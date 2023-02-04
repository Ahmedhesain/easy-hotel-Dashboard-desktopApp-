import 'package:get/get.dart';

import '../controllers/invoice_statement_by_case_controller.dart';

class InvoiceStatementByCaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceStatementByCaseController>(
      () => InvoiceStatementByCaseController(),
    );
  }
}
