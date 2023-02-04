import 'package:get/get.dart';

import '../controllers/invoices_query_controller.dart';

class InvoicesQueryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InvoicesQueryController() , permanent: true);
  }
}
