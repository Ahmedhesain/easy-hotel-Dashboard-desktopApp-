import 'package:get/get.dart';
import 'package:toby_bills/app/modules/reports/item_sales_by_customers/controllers/items_sales_by_customers_controller.dart';

class ItemsSalesByCustomersBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<ItemsSalesByCustomersController>(() => ItemsSalesByCustomersController());
  }

}
