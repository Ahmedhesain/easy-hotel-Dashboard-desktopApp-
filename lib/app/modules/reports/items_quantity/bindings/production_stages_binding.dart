import 'package:get/get.dart';
import 'package:toby_bills/app/modules/reports/items_quantity/controllers/items_quantity_controller.dart';

class QuantityItemsBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<QuantityItemsController>(() => QuantityItemsController());
  }

}
