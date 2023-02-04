import 'package:get/get.dart';
import 'package:toby_bills/app/modules/reports/inv_item/controllers/inv_item_controller.dart';
import 'package:toby_bills/app/modules/reports/items_quantity/controllers/items_quantity_controller.dart';
import 'package:toby_bills/app/modules/reports/profit_sold/controllers/profit_sold_controller.dart';

class InvItemBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<InvItemController>(() => InvItemController());
  }

}
