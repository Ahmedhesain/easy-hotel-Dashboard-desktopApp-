import 'package:get/get.dart';
import 'package:toby_bills/app/modules/reports/categories_items/controllers/categories_items_controller.dart';
import 'package:toby_bills/app/modules/reports/items_quantity/controllers/items_quantity_controller.dart';
import 'package:toby_bills/app/modules/reports/profit_sold/controllers/profit_sold_controller.dart';

class CategoriesItemsBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<CategoriesItemsController>(() => CategoriesItemsController());
  }

}
